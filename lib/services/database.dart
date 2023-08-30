import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_firebase_app/models/brew.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc().set({
      'sugars': sugars,
      'name': name,
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
  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}