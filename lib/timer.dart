import 'dart:async';

import 'package:flutter/material.dart';



class MyClass {
  DateTime now = DateTime.now(); // instance member

  MyClass() {
    now = DateTime.now(); // initialize in constructor
  }

  void someMethod() {
    now = DateTime.now(); // initialize in separate method
  }
}class MyClass2 {
  DateTime destination = DateTime(2023, 4, 2, 20, 34, 0); // instance member

  MyClass2() {
    destination = DateTime(2023, 4, 2, 20, 34, 0); // initialize in constructor
  }

  void someMethod() {
    destination = DateTime.now(); // initialize in separate method
  }
}

class CountdownPage extends StatefulWidget {
  final VoidCallback onCountdownComplete;
  const CountdownPage({Key? key, required this.onCountdownComplete}) : super(key: key);

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  Duration countdownDuration = MyClass2().destination.difference(MyClass().now);
  // static const countdownDuration = Duration(days: 10);
  Duration duration = Duration();
  Timer? timer;

  bool isCountdown = true;

  @override
  void initState() {
    super.initState();

    startTimer();
    reset();
  }

  void reset() {
    if (isCountdown) {
      setState(() {
        duration = countdownDuration;
      });
    }
    else {
      setState(() {
        duration = Duration();
      });
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      if(seconds <1) {
        timer?.cancel();
        widget.onCountdownComplete();
      }
      else{
        duration = Duration(seconds: seconds);
      }

      duration = Duration(seconds: seconds);
    });
  }
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    return buildTime();
  }
  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    //to make a new card add below
    final days = twoDigits(duration.inDays);
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [
          buildTimeCard(time: days, header: 'DAYS'),
          const SizedBox(width: 8),
          buildTimeCard(time: hours, header: 'HOURS'),
          const SizedBox(width: 8),

        ],),
        SizedBox(height: 30.0,),
        Row(
          children: [
            buildTimeCard(time: minutes, header: 'MINUTES'),
            const SizedBox(width: 8),
            buildTimeCard(time: seconds,header: 'SECONDS'),
          ],
        )


      ],
    );
  }
  Widget buildTimeCard({required String time, required String header}) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.30,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.height * 0.08,
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      Text(header),
    ],
  );
}