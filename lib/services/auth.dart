import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_firebase_app/models/person.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object base on FirebaseUser(User)
  Person? _userFromFirebaseUser(User? user) {
   return user != null ? Person(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Person?> get user {
    return _auth.authStateChanges()
    //.map((User user) => _userFromFirebaseUser(user));
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

  //register with email and password

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