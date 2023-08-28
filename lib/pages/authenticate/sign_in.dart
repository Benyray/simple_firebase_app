import 'package:flutter/material.dart';
import 'package:simple_firebase_app/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({super.key, required this.toggleView}); 

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth = AuthService();

// TextField state 
String email = '';
String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sing in to Brew Crew'),
        actions: [
          TextButton.icon(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(children: [
            SizedBox(height: 20.0,),
            TextFormField(
              onChanged: (val) {
                  setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              obscureText: true,
              onChanged: (val) {
                 setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
            //  style: ButtonStyle(backgroundColor: MaterialStateColor().green),
              child: Text('Sign In', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                print(email);
                print(password);
              },
            ),
          ]),
          ),
      /*    ElevatedButton(
          child: Text('Sing in anon'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null) {
              print('error signing in');
            } else {
              print('signed in');
              print(result.uid);
            }
          },
          ), */
      ),
    );
  }
}