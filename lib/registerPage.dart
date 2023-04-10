import 'dart:convert';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:dropdownfield2/dropdownfield2.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final __url = serverUrl().url;
List<Map<String, dynamic>> collegeData = [
  {
    "collegeId": 1,
    "universityName": "Acharya Nagarjuna University, Guntur (Id: U-0003)",
    "collegeName": "Aazad College of Education (Id: C-39230)",
    "district": "Prakasam",
    "state": "Andhra Pradesh",
    "country": "INDIA"
  },
  {
    "collegeId": 2,
    "universityName": "Acharya Nagarjuna University, Guntur (Id: U-0003)",
    "collegeName": "Abhinav Institute of Management & Technology (Id: C-39450)",
    "district": "Prakasam",
    "state": "Andhra Pradesh",
    "country": "INDIA"
  },
  {
    "collegeId": 3,
    "universityName": "Acharya Nagarjuna University, Guntur (Id: U-0003)",
    "collegeName": "Abhyudaya Mahila Degree College (Id: C-32630)",
    "district": "Guntur",
    "state": "Andhra Pradesh",
    "country": "INDIA"
  },
  {
    "collegeId": 4,
    "universityName": "Acharya Nagarjuna University, Guntur (Id: U-0003)",
    "collegeName": "A.B.M. College (Id: C-32735)",
    "district": "Prakasam",
    "state": "Andhra Pradesh",
    "country": "INDIA"
  },
  {
    "collegeId": 5,
    "universityName": "Acharya Nagarjuna University, Guntur (Id: U-0003)",
    "collegeName": "A.B.R College of Education (Id: C-39231)",
    "district": "Prakasam",
    "state": "Andhra Pradesh",
    "country": "INDIA"
  },
  {
    "collegeId": 6,
    "universityName": "Acharya Nagarjuna University, Guntur (Id: U-0003)",
    "collegeName": "A.C.College (Day) (Id: C-32762)",
    "district": "Guntur",
    "state": "Andhra Pradesh",
    "country": "INDIA"
  },
  {
    "collegeId": 7,
    "universityName": "Acharya Nagarjuna University, Guntur (Id: U-0003)",
    "collegeName": "A.C.College of Law (Id: C-32792)",
    "district": "Guntur",
    "state": "Andhra Pradesh",
    "country": "INDIA"
  }
];

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {

  bool _isCollegeValid = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _collegeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _sendDataToBackend() async {
    try {
      final response = await http.post(
        Uri.parse(__url + "userApp/registerUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fullName': _fullNameController.text,
          'userEmail': _emailController.text,
          'password': _passwordController.text,
          'collegeId': int.parse(_collegeController.text.split("-")[0].trim()),
        }),
      );
      // Handle the response as needed
      print(_collegeController.text);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      child: Image(
                        image: AssetImage('Images/anokha_circle.png'),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.width * 0.25),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xFF002845),
                        fontWeight: FontWeight.w500,
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
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TextFormField(
                                      controller: _fullNameController,
                                      decoration: InputDecoration(
                                        hintText: "Full Name",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your full name';
                                        }
                                        if (value.length > 25) {
                                          return 'Full name should be at most 25 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        hintText: "Email Address",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: (value) {
                                        final emailRegExp =
                                            RegExp(r'^[^@]+@[^@]+\.[^@]+');
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your email address';
                                        }
                                        if (!emailRegExp.hasMatch(value)) {
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
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword =
                                                  !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: _obscureConfirmPassword,
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureConfirmPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureConfirmPassword =
                                                  !_obscureConfirmPassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please confirm your password';
                                        }
                                        if (_passwordController.text != value) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: DropDownField(
                                      controller: _collegeController,
                                      hintText: "Select a College",
                                      enabled: true,
                                      items: collegeData.map((college) {
                                        return "${college['collegeId']} - ${college['collegeName']} (${college['state']}, ${college['district']})";
                                      }).toList(),
                                      onValueChanged: (value) {
                                        setState(() {
                                          _isCollegeValid = value != null && value.isNotEmpty;
                                        });
                                      },
                                    ),
                                  ),


                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        if (_formKey.currentState != null &&
                                            _formKey.currentState!.validate() &&
                                            _isCollegeValid) {
                                          // Proceed with sending data to the backend
                                          _sendDataToBackend();
                                        } else if (!_isCollegeValid) {
                                          // ScaffoldMessenger.of(context).showSnackBar(
                                          //   SnackBar(
                                          //     content: Text('Please select a college.'),
                                          //   ),
                                          // );
                                          print("Enter College Name");
                                        }
                                      },
                                      child: Text(
                                        "REGISTER",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      ),
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
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Already Registered?",
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1.0),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              color: Color(0xFFFF7F11)),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
