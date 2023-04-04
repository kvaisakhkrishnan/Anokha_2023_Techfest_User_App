// import 'dart:ui';
// import 'dart:async';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:rive/rive.dart';
//
//
//
// class OnBoard extends StatefulWidget {
//   OnBoard({Key? key}) : super(key: key);
//
//   @override
//   State<OnBoard> createState() => _OnBoardState();
// }
//
// class _OnBoardState extends State<OnBoard> {
//   double _position = 0.0;
//   double _position2 = 0.0;
//   bool _showText = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Trigger the animation after 1 second
//     Future.delayed(Duration(seconds: 9), () {
//       setState(() {
//         _position = -0.35 * MediaQuery.of(context).size.height;
//
//
//       });
//     });
//
//     Future.delayed(Duration(seconds: 11), () {
//       setState(() {
//         _showText = true;
//
//       });
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//
//           Positioned(
//             bottom: 200,
//             left: 100,
//             width: MediaQuery.of(context).size.width * 1.7,
//             child: Image.asset('Images/Spline.png'),
//           ),
//           RiveAnimation.asset('RiveAssets/shapes.riv'),
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(
//                 sigmaX: 90,
//                 sigmaY: 70,
//               ),
//               child: SizedBox(),
//             ),
//           ),
//           Center(
//             child: AnimatedContainer(
//               duration: Duration(seconds: 2),
//               curve: Curves.easeInOut,
//               child: SvgPicture.asset(
//                 'Images/anokha_circle.svg',
//                 width: 0.34 * MediaQuery.of(context).size.width,
//               ),
//               transform: Matrix4.translationValues(0, _position, 0),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             right: 0,
//
//             top: -0.40 * MediaQuery.of(context).size.height,
//             bottom: 0,
//
//             child: Center(
//               child: AnimatedOpacity(
//                 duration: Duration(seconds: 3),
//                 curve: Curves.easeInOut,
//                 opacity: _showText ? 1.0 : 0.0,
//                 child: Center(
//                   child: Text("anokha 2023",
//                   style: TextStyle(
//                     fontFamily: "SpinCycle",
//                     fontSize: MediaQuery.of(context).size.width * 0.13,
//                   ),),
//                 ),
//               ),
//             ),
//
//
//
//           ),
//
//
//           Positioned(
//             left: 0,
//             right: 0,
//
//             top: 0.23 * MediaQuery.of(context).size.height,
//             bottom: 0,
//
//             child: Center(
//               child: AnimatedOpacity(
//                 duration: Duration(seconds: 3),
//                 curve: Curves.easeInOut,
//                 opacity: _showText ? 1.0 : 0.0,
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: []),
//               ),
//             ),
//
//
//
//           ),
//
//
//         ],
//       ),
//     );
//   }
// }
//
//
// // class CountdownPage extends StatefulWidget {
// //   const CountdownPage({Key? key}) : super(key: key);
// //
// //   @override
// //   State<CountdownPage> createState() => _CountdownPageState();
// // }
// //
// // class _CountdownPageState extends State<CountdownPage> {
// //   Duration countdownDuration = MyClass2().destination.difference(MyClass().now);
// //   // static const countdownDuration = Duration(days: 10);
// //   Duration duration = Duration();
// //   Timer? timer;
// //
// //   bool isCountdown = true;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     startTimer();
// //     reset();
// //   }
// //
// //   void reset() {
// //     if (isCountdown) {
// //       setState(() {
// //         duration = countdownDuration;
// //       });
// //     }
// //     else {
// //       setState(() {
// //         duration = Duration();
// //       });
// //     }
// //   }
// //
// //   void addTime() {
// //     final addSeconds = isCountdown ? -1 : 1;
// //
// //     setState(() {
// //       final seconds = duration.inSeconds + addSeconds;
// //
// //       if(seconds <1) {
// //         timer?.cancel();
// //       }
// //       else{
// //         duration = Duration(seconds: seconds);
// //       }
// //
// //       duration = Duration(seconds: seconds);
// //     });
// //   }
// //   void startTimer() {
// //     timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return buildTime();
// //   }
// //   Widget buildTime() {
// //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// //     //to make a new card add below
// //     final days = twoDigits(duration.inDays);
// //     final hours = twoDigits(duration.inHours.remainder(24));
// //     final minutes = twoDigits(duration.inMinutes.remainder(60));
// //     final seconds = twoDigits(duration.inSeconds.remainder(60));
// //     return Column(mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         Row(children: [
// //           buildTimeCard(time: days, header: 'DAYS'),
// //           const SizedBox(width: 8),
// //           buildTimeCard(time: hours, header: 'HOURS'),
// //           const SizedBox(width: 8),
// //
// //         ],),
// //         SizedBox(height: 30.0,),
// //         Row(
// //           children: [
// //             buildTimeCard(time: minutes, header: 'MINUTES'),
// //             const SizedBox(width: 8),
// //             buildTimeCard(time: seconds,header: 'SECONDS'),
// //           ],
// //         )
// //
// //
// //       ],
// //     );
// //   }
// //   Widget buildTimeCard({required String time, required String header}) => Column(
// //     mainAxisAlignment: MainAxisAlignment.center,
// //     children: [
// //       Container(
// //         height: MediaQuery.of(context).size.height * 0.15,
// //         width: MediaQuery.of(context).size.width * 0.30,
// //         padding: EdgeInsets.all(8.0),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(20.0),
// //         ),
// //         child: Center(
// //           child: Text(
// //             time,
// //             style: TextStyle(
// //               fontWeight: FontWeight.bold,
// //               color: Colors.black,
// //               fontSize: MediaQuery.of(context).size.height * 0.08,
// //             ),
// //           ),
// //         ),
// //       ),
// //       const SizedBox(height: 15),
// //       Text(header),
// //     ],
// //   );
// // }