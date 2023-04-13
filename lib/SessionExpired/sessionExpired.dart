import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SessionExpired extends StatefulWidget {
  const SessionExpired({Key? key}) : super(key: key);

  @override
  State<SessionExpired> createState() => _SessionExpiredState();
}

class _SessionExpiredState extends State<SessionExpired> {
  @override
  Widget build(BuildContext context) {

        return AlertDialog(
          title: Text('Session Expired'),
          content: Text('Please login again'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Close the pop-up notification
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }

}
