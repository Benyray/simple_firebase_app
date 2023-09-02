import 'package:flutter/material.dart';
import 'package:simple_firebase_app/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final sugars = ['0 sugars','1 sugars', '2 sugars', '3 sugars', '4 sugars'];

  //form values
  String _currentName = '';
  String _currentSugars = '0 sugars';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Update your brew settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0,),
          TextFormField(
            decoration: TextInputDecoration.copyWith(hintText: 'name'),
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 20.0,),
          // dropbox
           DropdownButtonFormField(
            value: _currentSugars ?? '0 sugars',
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
            value: (_currentStrength ?? 100).toDouble(),
            min: 100,
            max: 900,
            divisions: 8,
            activeColor: Colors.brown[_currentStrength ?? 100 ],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
            //value: (_currentStrength).toDouble(),
            onChanged: (val) => setState(() => _currentStrength = val.round()),
          ),
          // update button
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.pink)),
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
          ),
        ],)
      );
}
}