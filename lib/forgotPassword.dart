import 'package:anokha_home/otpValidation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String _errormessage="";
  bool isValidEmail(String email) {
    final RegExp emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _sendEmailToBackend(String email) async {
    // Your API endpoint URL here
    final String url = "https://anokha.amrita.edu/api/userApp/forgotPassword";
    print(email);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(<String,String>{
      'userEmail':email,
    });
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print("body");
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: ((context) => OTPverifyforgot(token:json.decode(response.body)["SECRET_TOKEN"], email: email,))));
      // Handle successful response here
    } else {
      // Handle unsuccessful response here
      setState(() {
        _errormessage=jsonDecode(response.body)['error'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios_new),

        ),
      ),
      body: Column(
        children: [
          SizedBox(height: screenSize.height * 0.01),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.1,
                ),
                child: Container(
                  child: Image(
                    image: AssetImage('Images/logo.png'),
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
                  "Password Reset Portal",
                  style: GoogleFonts.dmSans(textStyle:  TextStyle(
                    fontSize: 25,
                    color: Color(0xFF002845),
                    fontWeight: FontWeight.w500,
                  )),
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
                      vertical: screenSize.height * 0.1,
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
                              SizedBox(height: screenSize.height * 0.01),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width * 0.01,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: TextFormField(
                                    style: GoogleFonts.dmSans(),
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
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.05,
                                ),
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      print("button pressed");
                                      await _sendEmailToBackend(
                                          _usernameController.text);
// Navigate to the next page or show a message
                                    }
                                  },
                                  child: Text(
                                    "SUBMIT",
                                    style: GoogleFonts.dmSans(textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16)),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Color(0xFFFF7F11),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenSize.height * 0.015,
                                        horizontal: screenSize.width * 0.27),
                                  ),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                              Text(_errormessage,style: TextStyle(color: Colors.red),)
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