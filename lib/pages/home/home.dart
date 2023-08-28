import 'package:flutter/material.dart';
import 'package:simple_firebase_app/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}