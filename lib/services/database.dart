import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_firebase_app/models/brew.dart';
import 'package:simple_firebase_app/models/person.dart';

class DatabaseService {

  final String uid;
  DatabaseService(this.uid);

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.doc().set({
      'name': name,
      'sugars': sugars,
      'strength': strength,
    });
  }

  // brew list from snapshot
List <Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
     return snapshot.docs.map((doc){
       return Brew(
         doc.get('name') ?? '',
         doc.get('sugars') ?? '0',
         doc.get('strength') ?? 0
       );
     }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid,
      snapshot.get('name') ?? '',
      snapshot.get('sugars') ?? '0 sugars',
      snapshot.get('strength') ?? 100,
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}