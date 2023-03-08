import 'package:anokha_home/otpValidation.dart';
import 'package:anokha_home/registerPage.dart';
import 'package:anokha_home/registeredEvents.dart';
import 'package:anokha_home/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Loading_Screens/events_loading.dart';
import 'controllerPage.dart';
import 'homePage.dart';

import 'onBoard.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  double screenOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Trigger the animation after 1 second
    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        screenOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Anokha 2023",
      home: Scaffold(body: Events_Loading_screen()),
      // home: Stack(
      //   children: [
      //     SplashScreen(),
      //     AnimatedOpacity(
      //     opacity: screenOpacity,
      //     duration: Duration(seconds: 1),
      //     child: OnBoard(),
      //   ),
      //
      //   ]
      // )
    );
  }
}
