// import 'dart:html';
import 'dart:ui';
import 'dart:async';
import 'package:anokha_home/ticketSample.dart';
import 'package:anokha_home/timer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class homepageWithTImer extends StatefulWidget {
  homepageWithTImer({Key? key}) : super(key: key);

  @override
  State<homepageWithTImer> createState() => _homepageWithTImerState();
}

class _homepageWithTImerState extends State<homepageWithTImer> {
  bool get isDestinationTimeReached {
    final DateTime now = DateTime.now();
    final DateTime destination = DateTime(2023, 4, 4, 23, 10, 0);
    return now.isAfter(destination);
  }

  double _position = 0.0;
  double _position2 = 0.0;
  // bool _showText = false;
  bool _showTimer = false;
  bool _showImage = false;

  bool _showNewWidget = false;

  void _handleCountdownComplete() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        // print("inside flase timer");
        _showTimer = false;
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          print("1 second");
          _showNewWidget = true;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showImage = true;
      });
    });

    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        // print(!isDestinationTimeReached);
        if (!isDestinationTimeReached) {
          print("inside timer");
          _showTimer = true;
        }
      });
    });

    Future.delayed(Duration(seconds: 7), () {
      setState(() {
        _position2 = -0.22 * MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Positioned(
            bottom: 200,
            left: 100,
            width: MediaQuery.of(context).size.width * 1.7,
            child: Image.asset('Images/Spline.png'),
          ),
          RiveAnimation.asset('RiveAssets/shapes.riv'),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 90,
                sigmaY: 70,
              ),
              child: SizedBox(),
            ),
          ),
          Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                opacity: _showImage ? 0.0 : 1.0,
                child: SvgPicture.asset(
                  'Images/anokha_circle.svg',
                  width: 0.34 * MediaQuery.of(context).size.width,
                ),
              ),
              transform: Matrix4.translationValues(0, _position, 0),
            ),
          ),

          AnimatedContainer(
            margin: EdgeInsets.only(
              left: 0.18 * MediaQuery.of(context).size.width,
              top : 0.10 * MediaQuery.of(context).size.height,
            ),
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            child: AnimatedOpacity(
              duration: Duration(seconds: 3),
              curve: Curves.easeInOut,
              opacity: _showTimer ? 1.0 : 0.0,
              child:
                  CountdownPage(onCountdownComplete: _handleCountdownComplete),
            ),
            transform: Matrix4.translationValues(0, _position2, 0),
          ),
          // AnimatedPositioned(
          //   duration: Duration(seconds: 3),
          //   curve: Curves.easeInOut,
          //   left: 0.18 * MediaQuery.of(context).size.width,
          //   right: 0,
          //   top: _showTimer
          //       ? 0
          //       : 0.15 * MediaQuery.of(context).size.height, // Change this line
          //   bottom: 0,
          //   child: Center(
          //     child: AnimatedOpacity(
          //       duration: Duration(seconds: 3),
          //       curve: Curves.easeInOut,
          //       opacity: _showTimer ? 1.0 : 0.0,
          //       child: CountdownPage(
          //           onCountdownComplete: _handleCountdownComplete),
          //     ),
          //   ),
          // ),

          Container(
            height: MediaQuery.of(context).size.height, // set height to the screen height
            width: MediaQuery.of(context).size.width, // set width to the screen width
            // color: Colors.white,
            child: AnimatedOpacity(
              duration: Duration(seconds: 5),
              curve: Curves.easeInOut,
              opacity: _showNewWidget ? 1.0 : 0.0,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -0.65 * MediaQuery.of(context).size.height,
            bottom: 0,
            child: Center(
              child: AnimatedOpacity(
                duration: Duration(seconds: 5),
                curve: Curves.easeInOut,
                opacity: _showNewWidget ? 1.0 : 0.0,
                child:
                MyTicketView() // Replace with the new widget you want to show
              ),
            ),
          ),

        ],
      ),
    );
  }
}

