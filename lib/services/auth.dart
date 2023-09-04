import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:simple_firebase_app/models/person.dart';
import 'package:simple_firebase_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object base on FirebaseUser(User)
  Person? _userFromFirebaseUser(User? user) {
   return user != null ? Person(user.uid) : null;
  }

  // auth change user stream
  Stream<Person?> get user {
    return _auth.authStateChanges()
    .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      User user = userCredential.user!;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
        print("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        print("Unknown error.");
      }
    } 
}

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user; 
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create a new document for the user with the uid
      await DatabaseService(user!.uid).updateUserData('new member', '0 sugars', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}