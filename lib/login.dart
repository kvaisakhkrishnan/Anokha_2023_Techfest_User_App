import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFC),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('assets/images/anokha_logo_login_page.png'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  color: Color(0xFFf3f2f7),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0xFFFFFFFC),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Username',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Password',
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
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
                              child: Text('LOGIN'),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.06),
                                      child: Text(
                                        'REGISTER',
                                        style: TextStyle(
                                          color: (Color(0xFFFF7F11)),
                                        ),
                                      ),
                                    ),
                                    flex: 9,
                                  ),
                                  Expanded(
                                      child: Icon(
                                    size: 18.0,
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                  )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                          color: (Colors.black),
                                        ),
                                      ),
                                    ),
                                    flex: 9,
                                  ),
                                  Expanded(
                                      child: Icon(
                                        size: 18.0,
                                    Icons.arrow_forward_ios,
                                    color: Colors.grey,
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
