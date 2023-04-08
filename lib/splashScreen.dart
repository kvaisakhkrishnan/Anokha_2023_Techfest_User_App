import 'dart:async';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

final __url = serverUrl().url;

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

  // void navigateToLogin() async {
  //   // Make API call here and wait for the response
  //   var response = await http.get(Uri.parse(url + 'userApp/getCollegeData'));
  //
  //   // Use the received response data to check if the data is fully received
  //   if (response.statusCode == 200) {
  //     var data = response.body;
  //     // Assuming 200 is a successful response code
  //     // Replace 'LoginScreen()' with the name of your login screen widget
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage(data:data)));
  //   } else {
  //     // Handle the error case if the response status code is not 200
  //     print('Error occurred while fetching data');
  //   }
  // }

  void navigateToLogin() {
    Timer(Duration(seconds: 6), () async {
      // Make API call here
      var response = await http.get(Uri.parse(__url + 'userApp/getCollegeData'));

      // Replace 'LoginScreen()' with the name of your login screen widget
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginPage()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcfcff),
      body: Center(
        child: Image(
          image: AssetImage('./Images/Anokha Animated Logo fin 2.gif'),
        ),
      ),
    );
  }
}