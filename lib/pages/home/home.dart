import 'package:flutter/material.dart';
import 'package:simple_firebase_app/models/brew.dart';
import 'package:simple_firebase_app/pages/home/settings_form.dart';
import 'package:simple_firebase_app/services/auth.dart';
import 'package:simple_firebase_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:simple_firebase_app/pages/home/brew_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: const SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService('').brews, 
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0, 
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.person, color: Colors.white,),
              label: const Text('logout', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                await _auth.signOut();
              },
          ),
          TextButton.icon(
          icon: const Icon(Icons.settings, color: Colors.white,), 
          label: const Text('Settings', style: TextStyle(color: Colors.white),),
          onPressed: () => _showSettingsPanel(),
          ), 
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          )
        ),
        child: const BrewList()
      ),
    ),
   );
  }
}