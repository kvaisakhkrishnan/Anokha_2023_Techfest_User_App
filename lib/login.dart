import 'package:anokha_home/registerPage.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:anokha_home/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'Loading_Screens/events_loading.dart';
import 'controllerPage.dart';
import 'forgotPassword.dart';
import 'package:crypto/crypto.dart';
import 'package:google_fonts/google_fonts.dart';


//Login page which takes userEmail and password and verifies with the backend.

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
  final int technical;
  final int noOfRegistrations;
  final String url;
  final int individualOrGroup;
  final int maxCount;
  int isStarred;
  int fees;
  int totalNumberOfSeats;
  String errorMessage = "";

  event_list(
      {required this.eventId,
      required this.name,
      required this.description,
      required this.date,
      required this.type,
      required this.venue,
      required this.time,
      required this.department,
      required this.day,
      required this.technical,
      required this.noOfRegistrations,
      required this.url,
      required this.individualOrGroup,
      required this.maxCount,
      required this.isStarred,
      required this.fees,
      required this.totalNumberOfSeats});
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
  final String passportId;
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

  User(
      {required this.userEmail,
      required this.fullName,
      required this.activePassport,
      required this.isAmritaCBE,
      required this.collegeName,
      required this.district,
      required this.state,
      required this.country,
      required this.SECRET_TOKEN,
      required this.passportId});
}

final __url = serverUrl().url;

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  List<events_grouped_by_category> list_of_events = [];
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> saveLoginCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> removeLoginCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  Future<void> loadLoginCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      _usernameController.text = email;
      _passwordController.text = password;
    }
  }

  @override
  void initState() {
    super.initState();
    loadLoginCredentials();
  }


  var loadingScreen = 0;

  String errorMessage = "";

  bool isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<int> loginUser(String username, String password) async {
    var bytes = utf8.encode(password);
    var digest = sha512.convert(bytes);
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Events_Loading_screen();
    //   },
    // );
    String url = __url + 'userApp/login';
    Map<String, String> data = {
      'userEmail': username,
      'password': digest.toString(),
    };
    String body = json.encode(data);

    try {
      //Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );


      print(response.statusCode.toString());
      // Check the response status
      if (response.statusCode == 200) {
        var userDetails = jsonDecode(response.body);
        print(userDetails["userData"]['collegeName']);
        if (userDetails["userData"]['passportId'] == null) {
          userDetails["userData"]['passportId'] = "NA";
        }

        userData = User(
            userEmail: userDetails["userData"]['userEmail'],
            fullName: userDetails["userData"]['fullName'],
            activePassport: userDetails["userData"]['activePassport'],
            isAmritaCBE: userDetails["userData"]['isAmritaCBE'],
            collegeName: userDetails["userData"]['collegeName'],
            district: "",
            state: "",
            country: "",
            SECRET_TOKEN: userDetails["userData"]['SECRET_TOKEN'],
            passportId: userDetails["userData"]['passportId']);

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
                day: events_in_a_row["date"],
                technical: events_in_a_row["technical"],
                noOfRegistrations: events_in_a_row["noOfRegistrations"],
                url: events_in_a_row["url"],
                individualOrGroup: events_in_a_row["groupOrIndividual"],
                maxCount: events_in_a_row["maxCount"],
                isStarred: events_in_a_row["isStarred"],
                fees: events_in_a_row["fees"],
                totalNumberOfSeats: events_in_a_row["totalNumberOfSeats"]);

            temp_event_list.add(temp_event_data);
          }

          events_grouped_by_category temp_data_row = events_grouped_by_category(
              title: temp_title, events_list: temp_event_list);
          list_of_events.add(temp_data_row);
        }

        return 1;
      } else {
        setState(() {
          errorMessage = "Check your Credentials";
        });
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      child: Image(
                        image: AssetImage('Images/logo.png'),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.width * 0.25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                    child: Text(
                      "Login Portal",
                      style: GoogleFonts.dmSans(
                        textStyle: TextStyle(
                          color: Color(0xff002845),
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      color: Color(0xffF3F2F7),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 40.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        hintText: "Registered Email",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter an email address';
                                        } else if (!isValidEmail(value)) {
                                          return 'Please enter a valid email address';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _passwordController,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        suffixIcon: IconButton(
                                          iconSize: 20.0,
                                          icon: _obscureText
                                              ? Icon(FontAwesomeIcons.eye)
                                              : Icon(FontAwesomeIcons.eyeSlash),
                                          onPressed: () {
                                            _toggle();
                                          },
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: OutlinedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // Add this line
                                            try {
                                              int status = await loginUser(
                                                _usernameController.text,
                                                _passwordController.text,
                                              );

                                              if (status == 1) {
                                                print("in status 1");
                                                await saveLoginCredentials(
                                                  _usernameController.text,
                                                  _passwordController.text,
                                                );
                                                // ignore: use_build_context_synchronously
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ControllerPage(
                                                      data: userData,
                                                      eventsList:
                                                          list_of_events,
                                                      onLogout:
                                                          removeLoginCredentials,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                _scaffoldMessengerKey
                                                    .currentState
                                                    ?.showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Invalid login credentials')),
                                                );
                                              }
                                            } catch (e) {
                                              print("Error: $e");
                                              _scaffoldMessengerKey.currentState
                                                  ?.showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'An error occurred while logging in')),
                                              );
                                            }
                                          }
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Color(0xFFFF7F11),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 13.0,
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3),
                                        ),
                                        child: Text(
                                          "LOGIN",
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0),
                                          ),
                                        )),
                                  ),
                                  if (errorMessage != "")
                                    Text(
                                      errorMessage,
                                      style:
                                          GoogleFonts.dmSans(color: Colors.red),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 30.0),
                                    child: Text(
                                      "New to Anokha 2023?",
                                      style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 17.0)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1.0),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RegisterPage(),
                                              ));
                                        },
                                        child: Text(
                                          "REGISTER",
                                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                                              color: Color(0xFFFF7F11))),
                                        )),
                                  ),
                                  SizedBox(),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1.0),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    forgotPasswordclass(),
                                              ));
                                        },
                                        child: Text(
                                          "Forgot Password",
                                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                                              color: Color(0xFFFF7F11))),
                                        )),
                                  ),
                                  SizedBox()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text(
                  'Made with 🖤️ by WMD',
                  style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 17.0),)
                ),
              ),
            ],
          ),
        ));
  }
}
