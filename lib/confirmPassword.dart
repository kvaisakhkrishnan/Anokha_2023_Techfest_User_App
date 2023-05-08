import 'dart:convert';
import 'dart:io';

import 'package:anokha_home/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

//Password Reset Page
class confirmPassword extends StatefulWidget {
  confirmPassword({Key? key, required this.token}) : super(key: key);
  var token;
  @override
  State<confirmPassword> createState() => _confirmPasswordState();
}

class _confirmPasswordState extends State<confirmPassword> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  String _errormessage="";
  final TextEditingController pass = TextEditingController();
  final TextEditingController repass = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  String? customConfirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 25) {
      return 'Password must be at least 25 characters long';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'(?=.[!@#$%^&])').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  Future<void> _sendtoBackend(String value1) async {
    var bytes = utf8.encode(value1);
    var digest = sha512.convert(bytes);
    final String url =
        "https://anokha.amrita.edu/api/userApp/forgotPassword/newPassword";
    final body = jsonEncode(<String, String>{
      'newPassword': digest.toString(),
    });
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer ${widget.token}"
    };

    final response1 =
    await http.post(Uri.parse(url), body: body, headers: headers);
    //print(value1);
    //print("sent");
    print(jsonDecode(response1.body));
    if (response1.statusCode == 200) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => loginPage())));
      // Handle successful response here
    } else {
      // Handle unsuccessful response here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: ((context) => loginPage())));
            },
          )),
      backgroundColor: Color(0xFFFFFFFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage("Images/logo.png"),width: MediaQuery.of(context).size.width * 0.5,),
            SizedBox(height:MediaQuery.of(context).size.height * 0.1),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFC),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),

                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                          bottom: MediaQuery.of(context).size.height * 0.04,
                        ),
                        child: Text(
                          "Reset Password",
                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                              color: Color(0xff002845),
                              fontSize:
                              MediaQuery.of(context).size.height * 0.035)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          style: GoogleFonts.dmSans(),
                          controller: pass,
                          validator: customConfirmPasswordValidator,
                          decoration: InputDecoration(
                            hintText: 'Enter New Password',
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
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          style: GoogleFonts.dmSans(),
                          controller: repass,
                          validator: customConfirmPasswordValidator,
                          decoration: InputDecoration(
                            hintText: 'Confirm New Password',
                            suffixIcon: IconButton(
                              iconSize: 20.0,
                              icon: _obscureText2
                                  ? Icon(FontAwesomeIcons.eye)
                                  : Icon(FontAwesomeIcons.eyeSlash),
                              onPressed: () {
                                _toggle2();
                              },
                            ),
                          ),
                          obscureText: _obscureText2,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
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
                          onPressed: () {
                            if (pass.text == repass.text&&pass.text!=""&&repass.text!="") {
                              _sendtoBackend(pass.text);
                            } else {
                              // Show an error message for password mismatch
                              setState(() {
                                _errormessage="Password Mismatch";
                              });
                            }
                          },
                          child: Text('RESET PASSWORD',
                          style: GoogleFonts.dmSans(),),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            Text(_errormessage,style: TextStyle(color: Colors.red),)
          ],
        ),
      ),
    );
  }
}