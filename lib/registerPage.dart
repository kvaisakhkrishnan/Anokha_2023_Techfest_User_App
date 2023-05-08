import 'dart:convert';
import 'dart:ffi';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'otpValidation.dart';
import 'package:crypto/crypto.dart';


//Page to register for Anokha 2023 account. Amrita students will be asked to use Amrita Useremail here.
class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final __url = serverUrl().url;


class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  String? customPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length > 25) {
      return 'Password cant exceed 25 characters';
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(value)) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }
    return null;
  }

  String errorMessage = "";
  bool isAmrita = false;

  bool _showCollegeError = false;

  bool _isCollegeValid = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _collegeController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final _formKey = GlobalKey<FormState>();

  String? customEmailValidator(String? value) {
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    if (!value.endsWith('@cb.students.amrita.edu') &&
        !value.endsWith('@av.amrita.edu') &&
        !value.endsWith('@cb.amrita.edu') &&
        !value.endsWith('@av.students.amrita.edu')) {

       if(_collegeController.text == "Amrita Vishwa Vidyapeetham")
        {
          return 'You are an Amrita student\nplease register with your college email address';
        }
       else if(_collegeController.text == ""){
        setState(() {
          _showCollegeError = true;
          _showCollegeError = true;
        });
        return null;
      }
    }
    setState(() {
      _showCollegeError = false;
    });
    return null;
  }


  String? customCollegeValidator(String? value){
    if(value == "")
      {
        return 'Please enter a valid college name';
      }
    else{
      _isCollegeValid = true;
      return null;
    }
  }


  Future<void> _sendDataToBackend() async {
    try {
      var bytes = utf8.encode(_passwordController.text);
      var digest = sha512.convert(bytes);
      final response = await http.post(
        Uri.parse(__url + "userApp/registerUser"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fullName': _fullNameController.text,
          'userEmail': _emailController.text,
          'phoneNumber': _mobileNumberController.text,
          'password': digest.toString(),
          'collegeName': _collegeController.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Extract the token from the response body
        final responseBody = jsonDecode(response.body);
        final String token = responseBody['SECRET_TOKEN'];

        // Navigate to the new page and pass the token
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OTPVerify(token: token, email: _emailController.text),
          ),
        );
      } else if (response.statusCode == 409) {
        print("in");
        setState(() {
          errorMessage = "You have already registered";
        });
        // Show an error below the register button
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You have already registered'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        // Show a generic error message
        setState(() {
          errorMessage = "You have already registered";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
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
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Container(
                      constraints: BoxConstraints.expand(
                          height: MediaQuery
                              .of(context)
                              .size
                              .width * 0.19),
                      child: Image(
                        image: const AssetImage('Images/logo.png'),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Text(
                      "Register",
                      style:GoogleFonts.dmSans(textStyle: TextStyle(
                        fontSize: 30.0,
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
                      color: const Color(0xffF3F2F7),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
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
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _fullNameController,
                                      decoration: const InputDecoration(
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

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.height * 0.02),
                                          child: Text("Amrita Coimbatore / Amaravati Student?",
                                            style: GoogleFonts.dmSans(),
                                            maxLines: 3,),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Padding(

                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                          child:  Checkbox(value: isAmrita,
                                              activeColor: Color(0xff002845),
                                              onChanged: (amrita) {

                                                setState(() {
                                                  isAmrita = amrita!;
                                                  if(isAmrita)
                                                    {
                                                      _collegeController.text = "Amrita Vishwa Vidyapeetham";
                                                    }
                                                  else{
                                                    _collegeController.text = "";
                                                  }
                                                });
                                              }),
                                        ),
                                      )

                                    ],
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _collegeController,
                                      decoration: const InputDecoration(
                                        hintText: "College Name",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: customCollegeValidator,
                                    ),
                                  ),








                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: "Email Address",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: customEmailValidator,
                                    ),
                                  ),



                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _mobileNumberController,
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        hintText: "Mobile Number",
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(width: 1,
                                              color: Color(0xffF3F2F7)),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your mobile number';
                                        }
                                        if (value.length != 10) {
                                          return 'Mobile number should be 10 digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        enabledBorder: const UnderlineInputBorder(
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
                                      validator: customPasswordValidator,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: TextFormField(
                                      style: GoogleFonts.dmSans(),
                                      onTap: () {
                                        setState(() {
                                          errorMessage = "";
                                        });
                                      },
                                      controller: _confirmPasswordController,
                                      obscureText: _obscureConfirmPassword,
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        enabledBorder: const UnderlineInputBorder(
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
                                    padding:
                                    const EdgeInsets.only(top: 30.0),
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
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(
                                            0xFFFF7F11),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 13.0,
                                            horizontal: MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.3),
                                      ),
                                      child:Text(
                                        "REGISTER",
                                        style: GoogleFonts.dmSans(textStyle:  TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0)),
                                      ),
                                    ),
                                  ),
                                  if(errorMessage != "")
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(errorMessage,
                                        style: GoogleFonts.dmSans(
                                            color: Colors.red),),
                                    ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "Already Registered?",
                                      style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 17.0)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 1.0),
                                    child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "LOGIN",
                                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                                              color: Color(0xFFFF7F11))),
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

