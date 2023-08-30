import 'package:flutter/material.dart';
import 'package:simple_firebase_app/models/brew.dart';
import 'package:simple_firebase_app/services/auth.dart';
import 'package:simple_firebase_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:simple_firebase_app/pages/home/brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid:'').brews, 
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0, 
          actions: [
            TextButton.icon(
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text('logout', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                await _auth.signOut();
              },
          )
        ],
      ),
      body: BrewList(),
    ),
      );
    //return StreamProvider<QuerySnapshot>.value(
      //initialData: null, value: null,
    //);
  }
}