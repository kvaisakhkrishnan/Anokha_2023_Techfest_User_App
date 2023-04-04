import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() {
    Timer(Duration(seconds: 6), () {
      // Replace 'LoginScreen()' with the name of your login screen widget
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcfcff),
      body:
      Center(
        child:
        Image(image: AssetImage(
          './Images/Anokha Animated Logo fin 2.gif'
        ),),
      ),
    );
  }
}
