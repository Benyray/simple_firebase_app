import 'package:flutter/material.dart';
import 'package:simple_firebase_app/models/person.dart';
import 'package:simple_firebase_app/services/database.dart';
import 'package:simple_firebase_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:simple_firebase_app/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final sugars = ['0 sugars','1 sugars', '2 sugars', '3 sugars', '4 sugars'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Person>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(user.uid).userData,
      builder: (context, snapshot) {
       // print(snapshot);
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          //print(userData!.name);
           return Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: TextInputDecoration.copyWith(hintText: 'name'),
                    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  const SizedBox(height: 20.0,),
                  // dropbox
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    decoration: TextInputDecoration.copyWith(hintText: '$_currentSugars'),
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text(sugar),
                      );
                    }).toList(), 
                    onChanged: (String? value) { _currentSugars = value!;},
                  ),
                  // slider
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    min: 100,
                    max: 900,
                    divisions: 8,
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    //value: (_currentStrength).toDouble(),
                    onChanged: (val) => setState(() => _currentStrength = val.round()),
                  ),
                  // update button
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)),
                    child: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {
                        await DatabaseService(user.uid).updateUserData(
                          _currentName ?? userData.name,
                          _currentSugars ?? userData.sugars,
                          _currentStrength ?? userData.strength,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],)
              );
        } else {
          return const Loading();
        }
      }
    );
}
}