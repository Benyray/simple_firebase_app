import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_firebase_app/pages/authenticate/authenticate.dart';
import 'package:simple_firebase_app/models/person.dart';
import 'package:simple_firebase_app/pages/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Person?>(context);
    print(user);

    if (user == null) {
      return Authenticate();
      }
    else { 
      return Home();
      }
  }
}