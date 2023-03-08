import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
