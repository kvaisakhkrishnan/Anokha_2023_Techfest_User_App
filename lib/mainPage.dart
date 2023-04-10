import 'dart:async'; // Added import statement for Timer
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String assetName = 'Images/campus.svg';

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    Timer(Duration(seconds: 5), () {
      // Do something after 5 seconds
      print('Timer completed!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00f2845),
      body: ListView(
        children: [
          SvgPicture.asset(
            'Images/campus.svg',
            semanticsLabel: 'Acme Logo',
            color: Colors.white,
          ),
          Center(
            child: Text(
              'Timer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
