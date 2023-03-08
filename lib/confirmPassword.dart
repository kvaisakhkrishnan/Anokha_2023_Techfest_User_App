import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class confirmPassword extends StatefulWidget {
  const confirmPassword({Key? key}) : super(key: key);

  @override
  State<confirmPassword> createState() => _confirmPasswordState();
}

class _confirmPasswordState extends State<confirmPassword> {
  bool _obscureText = true;
  bool _obscureText2 = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {},
          )),
      backgroundColor: Color(0xFFFFFFFC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/images/confirmpasswordimage.jpg'),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFC),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 30.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,bottom: MediaQuery.of(context).size.height * 0.04,),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.height * 0.035),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter New Password',
                            suffixIcon: IconButton(
                              iconSize: 20.0,
                              icon: _obscureText
                                  ? Icon(FontAwesomeIcons.eye)
                                  : Icon(FontAwesomeIcons.eyeSlash),
                              onPressed: () {
                                _toggle();
                              },
                            ),
                          ),
                          obscureText: _obscureText,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.05,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Confirm New Password',
                            suffixIcon: IconButton(
                              iconSize: 20.0,
                              icon: _obscureText
                                  ? Icon(FontAwesomeIcons.eye)
                                  : Icon(FontAwesomeIcons.eyeSlash),
                              onPressed: () {
                                _toggle2();
                              },
                            ),
                          ),
                          obscureText: _obscureText2,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF7F11),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('RESET PASSWORD'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
