import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class OTPverifyforgot extends StatefulWidget {
  var token;
  String email;
  OTPverifyforgot({Key? key, required this.token, required this.email})
      : super(key: key);

  @override
  State<OTPverifyforgot> createState() => _OTPverifyforgotState();
}

class _OTPverifyforgotState extends State<OTPverifyforgot> {
  late Timer _timer;
  int _remainingTime = 300;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          Navigator.pop(context); // Go back to the previous page
        }
      });
    });
  }

  Future<void> _sendtoBackend(String value) async {
    final String url =
        "https://anokha.amrita.edu/api/userApp/forgotPassword/verifyOtp";
    final response = await http.post(Uri.parse(url),
        body: {'otp': value},
        headers: {'authorization': 'Bearer ${widget.token}'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 40.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "VERIFY\nOTP",
                    style: GoogleFonts.montserrat(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  child: Text(
                    "We have send the verification code to",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.email, // Replace hardcoded email with the passed email
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Change Email?",
                      style:
                      TextStyle(fontSize: 18.0, color: Color(0xFFFF7F11)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: OtpTextField(
                  showFieldAsBox: true,
                  fieldWidth: 50.0,
                  focusedBorderColor: Color(0xFFFF7F11),
                  numberOfFields: 6,
                  filled: true,
                  fillColor: Color(0xffF3F2F7),
                  onSubmit: (value) {
                    _sendtoBackend(value);
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                      "Time Remaining: $_remainingTime seconds")),
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend OTP",
                        style:
                        TextStyle(fontSize: 18.0, color: Color(0xFFFF7F11)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "VERIFY",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xFFFF7F11),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.symmetric(
                                vertical: 13.0,
                                horizontal:
                                MediaQuery.of(context).size.width * 0.15)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
