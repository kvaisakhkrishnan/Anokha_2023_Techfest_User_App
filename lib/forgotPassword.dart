import 'package:anokha_home/otpValidation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'confirmPassword.dart';
import 'otpValidationforForgotpassword.dart';

class forgotPasswordclass extends StatefulWidget {
  const forgotPasswordclass({Key? key}) : super(key: key);

  @override
  State<forgotPasswordclass> createState() => _forgotPasswordclassState();
}

class _forgotPasswordclassState extends State<forgotPasswordclass> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  bool isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _sendEmailToBackend(String email) async {
    // Your API endpoint URL here
    final String url = "https://anokha.amrita.edu/api/userApp/forgotPassword";

    final response = await http.post(
      Uri.parse(url),
      body: {'userEmail': email},
    );

    if (response.statusCode == 200) {
      Navigator.push(context,MaterialPageRoute(builder: ((context) => OTPverifyforgot(token:json.decode(response.body)["SECRET_TOKEN"], email: email,))));
      // Handle successful response here
    } else {
      // Handle unsuccessful response here
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.1),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1,
                ),
                child: Container(
                  child: Image(
                    image: AssetImage('Images/anokha_circle.png'),
                    width: screenSize.width * 0.3,
                  ),
                  constraints: BoxConstraints.expand(
                    height: screenSize.width * 0.25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                  bottom: screenSize.height * 0.025,
                ),
                child: Text(
                  "Login Portal",
                  style: TextStyle(
                    fontSize: screenSize.height * 0.04,
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
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.15,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: screenSize.height * 0.05),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.05,
                                ),
                                child: TextFormField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    hintText: "Enter email address",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: Color(0xffF3F2F7),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email address';
                                    } else if (!isValidEmail(value)) {
                                      return 'Please enter a validemail address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.05,
                                ),
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _sendEmailToBackend(
                                          _usernameController.text);
// Navigate to the next page or show a message
                                    }
                                  },
                                  child: Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenSize.height * 0.025),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF7F11),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.02,
                                        horizontal: screenSize.width * 0.3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
