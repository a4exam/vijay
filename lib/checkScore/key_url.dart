
import 'package:flutter/material.dart';
import 'package:mcq/checkScore/reusable_widget.dart';

import 'cutoff_score.dart';

class KeyUrl extends StatefulWidget {
  const KeyUrl({super.key});

  @override
  State<KeyUrl> createState() => _KeyUrlState();
}

class _KeyUrlState extends State<KeyUrl> {
  final TextEditingController _url = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _horizontalReservation = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _district = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Exam name',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .90,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    'Please enter answer key URL',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  reusableTextField('Your URL here', null, false, _url),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                    hint: const Text('Select Gender'),
                    // Hint text displayed when no value is selected
                    items: <String>['Male', 'Female', 'Other'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _gender = newValue; // Update the selected value
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  reusableTextField('Category', Icons.ac_unit, false, _category),

                  const SizedBox(height: 16),

                  reusableTextField('Horizontal Reservation', Icons.ac_unit, false, _horizontalReservation),

                  const SizedBox(height: 16),

                  reusableTextField('State', Icons.location_on, false, _state),

                  const SizedBox(height: 16),

                  reusableTextField('District', Icons.location_on, false, _district),

                  const SizedBox(height: 16),

                  reusableTextField('set a password', Icons.school, true, _password),

                  const SizedBox(height: 16),
                  
                  reusableButton(context, 'Submit', (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const CutoffScore()));
                    print('Your URL: ${_url.text.toString()}');
                    print('Gender: ${_gender.toString()}');
                    print('Category: ${_category.text.toString()}');
                    print('Horizontal Reservation: ${_horizontalReservation.text.toString()}');
                    print('State: ${_state.text.toString()}');
                    print('District: ${_district.text.toString()}');
                    print('Password: ${_password.text.toString()}');

                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
