import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventRegistrationForm extends StatefulWidget {
  final jsonData;
  const EventRegistrationForm({Key? key, required this.jsonData})
      : super(key: key);

  @override
  State<EventRegistrationForm> createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  int _numOfParticipants = 1;
  List<TextEditingController> _emailControllers = [TextEditingController()];
  TextEditingController _groupNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _updateControllers(int newValue) {
    if (newValue > _numOfParticipants) {
      for (int i = _numOfParticipants; i < newValue; i++) {
        _emailControllers.add(TextEditingController());
      }
    } else {
      _emailControllers.removeRange(newValue, _emailControllers.length);
    }
    setState(() {
      _numOfParticipants = newValue;
    });
  }

  List<Widget> _buildParticipantFields() {
    List<Widget> participantFields = [];
    for (int i = 0; i < _numOfParticipants; i++) {
      participantFields.add(
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              TextFormField(
                controller: _emailControllers[i],
                decoration: InputDecoration(
                  hintText: 'Email address',
                ),
                validator: (value) {
                  if (!isValidEmail(value ?? '')) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: i == 0 ? 'Leader' : 'Member',
                ),
                enabled: false,
              ),
            ],
          ),
        ),
      );
      if (i != _numOfParticipants - 1) {
        participantFields.add(SizedBox(height: 10));
      }
    }
    return participantFields;
  }

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  bool _formIsValid() {
    return _formKey.currentState?.validate() ?? false;
  }


  Future<void> _submitData() async {
    if (!_formIsValid()) {
      return;
    }

    const String API_ENDPOINT = "https://your-api-endpoint.com";
    List<Map<String, dynamic>> participants = [];

    for (int i = 0; i < _numOfParticipants; i++) {
      participants.add({
        'email': _emailControllers[i].text,
        'role': i == 0 ? 'Leader' : 'Member',
      });
    }

    Map<String, dynamic> data = {
      'group_name': _groupNameController.text,
      'participants': participants,
    };
    print(participants);
    try {
      final response = await http.post(
        Uri.parse(API_ENDPOINT),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        // Handle success
      } else {
        // Handle error
      }
    } catch (e) {
      // Handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.07),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Color(0xFFFF7F11),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Registration Of Event',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: TextFormField(
                  controller: _groupNameController,
                  decoration: InputDecoration(hintText: 'Group Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                decoration: BoxDecoration(
                    color: Color(0xffF3F2F7),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: _numOfParticipants <= 1
                              ? null
                              : () {
                                  int newValue = _numOfParticipants - 1;
                                  _updateControllers(newValue);
                                },
                        ),
                        SizedBox(width: 10),
                        Text("Number of Participants: $_numOfParticipants"),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed:
                              _numOfParticipants >= widget.jsonData.maxCount
                                  ? null
                                  : () {
                                      int newValue = _numOfParticipants + 1;
                                      _updateControllers(newValue);
                                    },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ..._buildParticipantFields(),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ElevatedButton(
                onPressed: () {
                  if (_formIsValid()) {
                    _formKey.currentState?.save();
                    _submitData();
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFFF7F11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
