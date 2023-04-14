import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../login.dart';

class SessionExpired extends StatefulWidget {
  const SessionExpired({Key? key}) : super(key: key);

  @override
  State<SessionExpired> createState() => _SessionExpiredState();
}

class _SessionExpiredState extends State<SessionExpired> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff002845),
        body: AlertDialog(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Session Expired'),
          content: Text('Please login again'),
          actions: [
            TextButton(
              child: Text('OK',
              style: TextStyle(color: Color(0xff002845)),),
              onPressed: () {
                // Close the pop-up notification
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => loginPage()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        )
    );
  }

}
