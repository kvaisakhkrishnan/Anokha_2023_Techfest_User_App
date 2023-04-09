import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventRegistrationForm extends StatefulWidget {
  final jsonData;
  final data;
  const EventRegistrationForm({Key? key, required this.jsonData, required this.data})
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                  alignment:Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Text("Participant ${i+1}",
                      style: TextStyle(
                          fontSize: 16.0
                      ),),
                  )),
              TextFormField(
                controller: i == 0
                    ? TextEditingController(text: widget.data.userEmail)
                    : _emailControllers[i],
                decoration: InputDecoration(
                  hintText: 'Email address',
                ),
                enabled: i != 0,
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
    print(widget.data);
    if (!_formIsValid()) {
      return;
    }

    const String API_ENDPOINT = "https://your-api-endpoint.com";
    List<Map<String, dynamic>> participants = [];

    for (int i = 0; i < _numOfParticipants; i++) {
      participants.add({
        'email': i == 0 ? widget.data.userEmail : _emailControllers[i].text,
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
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, toolbarHeight: 0, backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.0),
                decoration: BoxDecoration(
                    color: Color(0xffF3F2F7),
                    borderRadius: BorderRadius.circular(30)),
                height: MediaQuery.of(context).size.height * 0.66,
                width: MediaQuery.of(context).size.width * 0.90,
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
                        Text("Number of Participants: $_numOfParticipants",
                            style: TextStyle(
                                fontSize: 15.0
                            )),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  if (_formIsValid()) {
                    _formKey.currentState?.save();
                    _submitData();
                  }
                },
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.7, MediaQuery.of(context).size.height * 0.06),
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