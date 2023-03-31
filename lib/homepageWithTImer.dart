// import 'dart:html';
import 'dart:ui';
import 'dart:async';
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
    final DateTime destination = DateTime(2023, 3, 31, 1, 19, 20);
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
    // Trigger the animation after 1 second
    // Future.delayed(Duration(seconds: 9), () {
    //   setState(() {
    //     _position = -0.35 * MediaQuery.of(context).size.height;
    //
    //
    //   });
    // });

    // Future.delayed(Duration(seconds: 11), () {
    //   setState(() {
    //     _showText = true;
    //
    //   });
    // });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _showImage = true;

      });
    });

    // Future.delayed(Duration(seconds: 13), () {
    //   setState(() {
    //     _showText = false;
    //   });
    // });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        if (!isDestinationTimeReached) {
          _showTimer = true;
        }
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
                duration: Duration(seconds: 3),
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

          // Text
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: -0.40 * MediaQuery.of(context).size.height,
          //   bottom: 0,
          //   child: Center(
          //     child: AnimatedOpacity(
          //       duration: Duration(seconds: 3),
          //       curve: Curves.easeInOut,
          //       opacity: _showText ? 1.0 : 0.0,
          //       child: Center(
          //         child: Text(
          //           "anokha 2023",
          //           style: TextStyle(
          //             fontFamily: "SpinCycle",
          //             fontSize: MediaQuery.of(context).size.width * 0.13,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),


          Positioned(
            left: 0.18 * MediaQuery.of(context).size.width,
            right: 0,
            top: 0.15 * MediaQuery.of(context).size.height,
            bottom: 0,
            child: Center(
              child: AnimatedOpacity(
                duration: Duration(seconds: 3),
                curve: Curves.easeInOut,
                opacity: _showTimer ? 1.0 : 0.0,
                child: CountdownPage(onCountdownComplete: _handleCountdownComplete), // Replace with your timer widget
              ),
            ),



          ),

          Positioned(
            left: 0,
            right: 0,
            top: 0.23 * MediaQuery.of(context).size.height,
            bottom: 0,
            child: Center(
              child: AnimatedOpacity(
                duration: Duration(seconds: 5),
                curve: Curves.easeInOut,
                opacity: _showNewWidget ? 1.0 : 0.0,
                child: TicketShape(), // Replace with the new widget you want to show
              ),
            ),
          ),



        ],
      ),
    );
  }
}



class TicketShape extends StatelessWidget {
  const TicketShape({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          _buildPunchHole(0.25),
          _buildPunchHole(0.5),
          _buildPunchHole(0.75),
        ],
      ),
    );
  }

  Positioned _buildPunchHole(double relativeWidth) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double holeSize = 10;
          final double holeLeft = (constraints.maxWidth - holeSize) * relativeWidth;
          return Stack(
            children: [
              Positioned(
                left: holeLeft,
                top: -holeSize / 2,
                child: _createCircle(holeSize),
              ),
              Positioned(
                left: holeLeft,
                bottom: -holeSize / 2,
                child: _createCircle(holeSize),
              ),
            ],
          );
        },
      ),
    );
  }

  ClipOval _createCircle(double size) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        color: Colors.transparent,
      ),
    );
  }
}