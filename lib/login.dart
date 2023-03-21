import 'package:anokha_home/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String userEmail;
  final String fullName;
  final int activePassport;
  final int isAmritaCBE;
  final String collegeName;
  final String district;
  final String state;
  final String country;

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


  });

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     userEmail: json['userEmail'],
  //     fullName: json['fullName'],
  //     activePassport: json['activePassport'],
  //     isAmritaCBE: json['isAmritaCBE'],
  //     collegeName: json['collegeName'],
  //     district: json['district'],
  //     state: json['state'],
  //     country: json['country'],
  //   );
  // }
}


class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<int> loginUser(String username, String password) async {
    // print(username);
    final response = await http.get(
      Uri.parse('http://18.182.1.81:3000/userApp/login/$username/$password'),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      // var userDetails = jsonResponse['details'];
      // if (userDetails != null) {
      //   User user = User(
      //     userEmail: userDetails['userEmail'],
      //     fullName: userDetails['fullName'],
      //     activePassport: userDetails['activePassport'],
      //     isAmritaCBE: userDetails['isAmritaCBE'],
      //     collegeName: userDetails['collegeName'],
      //     district: userDetails['district'],
      //     state: userDetails['state'],
      //     country: userDetails['country'],
      //   );
      //   print(user);
      // }
      if (jsonResponse['status'] == 1) {
        var userDetails = jsonResponse['details'];
        if (userDetails != null) {
          User user = User(
            userEmail: userDetails['userEmail'],
            fullName: userDetails['fullName'],
            activePassport: userDetails['activePassport'],
            isAmritaCBE: userDetails['isAmritaCBE'],
            collegeName: userDetails['collegeName'],
            district: userDetails['district'],
            state: userDetails['state'],
            country: userDetails['country'],
          );
          print(user);
        }

        return 1;
      } else {
        return 0;
      }
    } else {
      throw Exception('Failed to load login data');
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => userProf(avatarLink: '',)), // Replace NextScreen with the target screen widget
                                    );
                                  } else {
                                    // print("in sn");
                                    // _scaffoldMessengerKey.currentState?.showSnackBar(
                                    //   SnackBar(content: Text('Invalid login details')),
                                    // );

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
                              onPressed: () {},
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
                              onPressed: () {},
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
