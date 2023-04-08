import 'package:anokha_home/registerPage.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:anokha_home/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'controllerPage.dart';
import 'forgotPassword.dart';

var userData;




class event_list {
  final int eventId;
  final String name;
  final String description;
  final String date;
  final int type;
  final String venue;
  final String time;
  final String department;
  final String day;

  event_list(
      {required this.eventId,
        required this.name,
        required this.description,
        required this.date,
        required this.type,
        required this.venue,
        required this.time,
        required this.department,
        required this.day});
}
class events_grouped_by_category {
  final String title;
  final List<event_list> events_list;


  events_grouped_by_category({required this.title, required this.events_list});
}






class User {
  final String userEmail;
  final String fullName;
  final int activePassport;
  final int isAmritaCBE;
  final String collegeName;
  final String district;
  final String state;
  final String country;
  final String SECRET_TOKEN;

  @override
  String toString() {
    return 'User{userEmail: $userEmail, fullName: $fullName, activePassport: $activePassport, isAmritaCBE: $isAmritaCBE, collegeName: $collegeName, district: $district, state: $state, country: $country}';
  }
  User({
    required this.userEmail,
    required this.fullName,
    required this.activePassport,
    required this.isAmritaCBE,
    required this.collegeName,
    required this.district,
    required this.state,
    required this.country,
    required this.SECRET_TOKEN


  });

}

final __url = serverUrl().url;

class loginPage extends StatefulWidget {
  final dynamic data;
  const loginPage({Key? key, this.data}) : super(key: key);


  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  List<events_grouped_by_category> list_of_events = [];
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<int> loginUser(String username, String password) async {

    String url = __url + 'userApp/login';
    Map<String, String> data = {
      'userEmail': username,
      'password': password,
    };
    String body = json.encode(data);

    try {
      //Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Check the response status
      if (response.statusCode == 200) {
        var userDetails = jsonDecode(response.body);

        userData = User(
            userEmail: userDetails["userData"]['userEmail'],
            fullName: userDetails["userData"]['fullName'],
            activePassport: userDetails["userData"]['activePassport'],
            isAmritaCBE: userDetails["userData"]['isAmritaCBE'],
            collegeName: userDetails["userData"]['collegeName'],
            district: userDetails["userData"]['district'],
            state: userDetails["userData"]['state'],
            country: userDetails["userData"]['country'],
            SECRET_TOKEN: userDetails["userData"]['SECRET_TOKEN']
        );





        for (var individual_data in userDetails["events"]) {

          String temp_title = individual_data["department"];
          List<event_list> temp_event_list = [];
          for (var events_in_a_row in individual_data["events"]) {


            event_list temp_event_data = event_list(
                eventId: events_in_a_row["eventId"],
                name: events_in_a_row["eventName"],
                description: events_in_a_row["description"],
                date: events_in_a_row["date"],
                type: events_in_a_row["eventOrWorkshop"],
                venue: events_in_a_row["venue"],
                time: events_in_a_row["eventTime"],
                department: events_in_a_row["departmentAbbr"],
                day: events_in_a_row["date"]);



            temp_event_list.add(temp_event_data);

          }


          events_grouped_by_category temp_data_row = events_grouped_by_category(
              title: temp_title, events_list: temp_event_list);
          list_of_events.add(temp_data_row);

        }



        return 1;

      } else {
        return 0;
      }
    } catch (e) {
      print('Server is down!');
      return 0;
    }


  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      backgroundColor: Color(0xFFFFFFFC),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('Images/logo.png'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Color(0xFFf3f2f7),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFFFFFFC),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                hintText: 'Username',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                  iconSize: 20.0,
                                  icon: _obscureText
                                      ? Icon(FontAwesomeIcons.eye)
                                      : Icon(FontAwesomeIcons.eyeSlash),
                                  onPressed: () {
                                    _toggle();
                                  },
                                ),
                              ),
                              obscureText: _obscureText,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFF7F11),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () async {
                                try {
                                  int status = await loginUser(
                                    _usernameController.text,
                                    _passwordController.text,
                                  );
                                  // print;

                                  if (status == 1) {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ControllerPage(data: userData, eventsList : list_of_events)));

                                  } else {

                                    void _showSnackBar(BuildContext context, String message) {
                                      final snackBar = SnackBar(
                                        content: Text(message),
                                        backgroundColor: Colors.grey,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                    _showSnackBar(context, "Invalid login details");
                                  }
                                } catch (e) {
                                  print("Error: $e");
                                  _scaffoldMessengerKey.currentState?.showSnackBar(
                                    SnackBar(content: Text('An error occurred while logging in')),
                                  );
                                }
                              },
                              child: Text('LOGIN'),
                            ),

                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextButton(
                              onPressed: () {
                                print(widget.data);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterPage(data: widget.data)),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.06),
                                      child: Text(
                                        'REGISTER',
                                        style: TextStyle(
                                          color: (Color(0xFFFF7F11)),
                                        ),
                                      ),
                                    ),
                                    flex: 9,
                                  ),
                                  Expanded(
                                      child: Icon(
                                        size: 18.0,
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => forgotPassword()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                          color: (Colors.black),
                                        ),
                                      ),
                                    ),
                                    flex: 9,
                                  ),
                                  Expanded(
                                      child: Icon(
                                        size: 18.0,
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}