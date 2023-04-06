import 'package:anokha_home/otpValidation.dart';
import 'package:anokha_home/registerPage.dart';
import 'package:anokha_home/registeredEvents.dart';
import 'package:anokha_home/splashScreen.dart';
import 'package:anokha_home/ticketSample.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'controllerPage.dart';
import 'forgotPassword.dart';
import 'homePage.dart';

import 'homepageWithTImer.dart';
import 'individualRegister.dart';
import 'login.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SplashScreen(),
      )
    );
  }
}

