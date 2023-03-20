import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'confirmPassword.dart';


class forgotPassword extends StatefulWidget {
  const forgotPassword({Key? key}) : super(key: key);

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  Future<int> emailExists(String email) async {
    final response = await http.get(
      Uri.parse('http://192.168.38.227:3000/mithundeandi'), // Replace with your API URL
      // body: jsonEncode({'email': email}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // print("in");
      final responseBody = jsonDecode(response.body);
      // print(responseBody['exist']);
      return responseBody['exist']; // Replace 'exists' with the appropriate key from your API response
    } else {
      throw Exception('Failed to check email');
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
            onPressed: () {},
          )),
      backgroundColor: Color(0xFFFFFFFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              // child: Image.asset('assets/images/forgotpasswordimage.jpg'),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFC),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 30.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,bottom: MediaQuery.of(context).size.height * 0.04,),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.height * 0.035),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter Your Email',
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.2,),
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
                            final emailController = TextEditingController();
                            int exists = await emailExists(emailController.text);
                            print(exists);
                            if (exists == 1) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => confirmPassword()), // Replace NextScreen with the target screen widget
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Email not found')),
                              );
                            }
                          },

                          child: Text('SUBMIT'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
