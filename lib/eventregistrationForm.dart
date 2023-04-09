import 'package:flutter/material.dart';

class EventRegistrationForm extends StatefulWidget {
  final Map<String, dynamic> jsonData;
  const EventRegistrationForm({Key? key, required this.jsonData})
      : super(key: key);

  @override
  State<EventRegistrationForm> createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  int _numOfParticipants = 1;
  List<TextEditingController> _emailControllers = [TextEditingController()];
  List<TextEditingController> _roleControllers = [TextEditingController()];

  void _updateControllers(int newValue) {
    if (newValue > _numOfParticipants) {
      for (int i = _numOfParticipants; i < newValue; i++) {
        _emailControllers.add(TextEditingController());
        _roleControllers.add(TextEditingController());
      }
    } else {
      _emailControllers.removeRange(newValue, _emailControllers.length);
      _roleControllers.removeRange(newValue, _roleControllers.length);
    }
    setState(() {
      _numOfParticipants = newValue;
    });
  }

  List<Widget> _buildParticipantFields() {
    List<Widget> participantFields = [];
    for (int i = 0; i < _numOfParticipants; i++) {
      participantFields.add(Row(
        children: [
          Expanded(
            child: TextField(
              controller: _emailControllers[i],
              decoration: InputDecoration(hintText: 'Email address'),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _roleControllers[i],
              decoration: InputDecoration(hintText: 'Role'),
            ),
          ),
        ],
      ));
      if (i != _numOfParticipants - 1) {
        participantFields.add(SizedBox(height: 10));
      }
    }
    return participantFields;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            decoration: BoxDecoration(
                color: Color(0xffF3F2F7),
                borderRadius: BorderRadius.circular(10)),
            height: MediaQuery.of(context).size.height * 0.7,
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
                      onPressed: _numOfParticipants >=
                              widget.jsonData['maximum_number_of_participants']
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
        ],
      ),
    );
  }
}
