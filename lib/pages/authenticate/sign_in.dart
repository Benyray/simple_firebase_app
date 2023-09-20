import 'package:flutter/material.dart';
import 'package:simple_firebase_app/services/auth.dart';
import 'package:simple_firebase_app/shared/constants.dart';
import 'package:simple_firebase_app/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({super.key, required this.toggleView}); 

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

final AuthService _auth = AuthService();
final _formKey = GlobalKey<FormState>();
bool loading = false;

// TextField state 
String email = '';
String password = '';
String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sing in to Brew Crew'),
        actions: [
          TextButton.icon(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
            icon: const Icon(Icons.person),
            label: const Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            const SizedBox(height: 20.0,),
            TextFormField(
              decoration: TextInputDecoration,
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) {
                  setState(() => email = val);
              },
            ),
            const SizedBox(height: 20.0,),
            TextFormField(
              decoration: TextInputDecoration.copyWith(hintText: 'password'),
              validator: (val) => val!.length < 6 ? 'Enter password 6+ chars long' : null,
              obscureText: true,
              onChanged: (val) {
                 setState(() => password = val);
              },
            ),
            const SizedBox(height: 20.0,),
            ElevatedButton(
            //  style: ButtonStyle(backgroundColor: MaterialStateColor().green),
              child: const Text('Sign In', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                 if (result == null) {
                    setState(()  {
                      error = 'Could not sign in with whis cedentials';
                      loading = false;
                      });
                  } 
                }
              },
            ),
            const SizedBox(height: 12.0,),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 14.0),
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