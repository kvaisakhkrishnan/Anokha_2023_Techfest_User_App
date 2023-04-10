import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class Events_Loading_screen extends StatefulWidget {
  Events_Loading_screen({Key? key}) : super(key: key);

  @override
  State<Events_Loading_screen> createState() => _Events_Loading_screenState();
}

class _Events_Loading_screenState extends State<Events_Loading_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff002845),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: Shimmer.fromColors(
              child: Image(image: AssetImage('./Images/logo.png'),),
              baseColor: Colors.grey.withOpacity(0.8),
              highlightColor: Colors.white.withOpacity(0.2),
          period: const Duration(seconds: 2),),
        ),
      ),
    );
  }
}
