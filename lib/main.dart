import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_firebase_app/pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:simple_firebase_app/services/auth.dart';
import 'models/person.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Person?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
              home: Wrapper(),
            ),
    );
  }
}