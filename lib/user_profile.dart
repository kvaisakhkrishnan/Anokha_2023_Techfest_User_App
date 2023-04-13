import 'package:flutter/material.dart';

import 'buyPassport.dart';
import 'login.dart';

class userProf extends StatefulWidget {
  final String avatarLink;
  final data;
  final VoidCallback onLogout;

  userProf({
    Key? key,
    required this.avatarLink,
    required this.data,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<userProf> createState() => _userProfState();
}

class _userProfState extends State<userProf> {
  bool islight = false;

  refresh() {
    setState(() {
      if (islight)
        islight = false;
      else
        islight = true;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: TextStyle(color: Color(0xFF002845))),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes', style: TextStyle(color: Color(0xFF002845))),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    void _showImageDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Container(
            child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png'),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: islight ? Color(0xFFFFFFFC) : Color(0xFF002845),
          appBar: AppBar(
            backgroundColor: Color(0xff002845),
            elevation: 0.0,
            actions: [
              IconButton(
                onPressed: () {
                  widget.onLogout(); // Call the callback function
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => loginPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(Icons.power_settings_new),
                color: Color(0xFFFF3F00),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.00,
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.01),
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color:
                              islight ? Color(0xFF002845) : Color(0xFFFFFFFC),
                        ),
                        // color: Colors.black,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.09),
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: Image(
                                  image: AssetImage('Images/logo.png'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Text(
                                  widget.data.activePassport == 1
                                      ? 'PASSPORT'
                                      : 'PROFILE',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      color: islight
                                          ? Color(0xFFBEB7AA)
                                          : Color(0xFF002845),
                                      fontFamily: 'Roboto'),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.004),
                                  alignment: Alignment.topCenter,
                                  child: Divider(
                                    color: islight
                                        ? Color(0xFFFFFFFC)
                                        : Color(0xFF002845),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: Text(
                                  widget.data.fullName,
                                  style: TextStyle(
                                      fontSize: 0.027 *
                                          MediaQuery.of(context).size.height,
                                      color: islight
                                          ? Color(0xFFFFFFFC)
                                          : Color(0xFF002845),
                                      fontFamily: "Roboto"),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
                                child: Text(
                                  widget.data.userEmail,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 0.018 *
                                          MediaQuery.of(context).size.height,
                                      color: islight
                                          ? Color(0xFFBEB7AA)
                                          : Color(0xFF002845),
                                      fontFamily: "Roboto"),
                                ),
                              ),
                              (widget.data.activePassport == 0)
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PassportBuy(),
                                              ));
                                        },
                                        child: Text("Buy Passport"),
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          primary: Color(0xff002845),
                                        ),
                                      ))
                                  : Text(widget.data.passportId),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                child: GestureDetector(
                                  onTap: () {
                                    _showImageDialog(context);
                                  },
                                  child: Hero(
                                    tag: 'imageTag',
                                    child: Container(
                                      child: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png',
                                          color: islight
                                              ? Color(0xFFBEB7AA)
                                              : Color(0xFF002845)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0,
                        child: CircleAvatar(
                          maxRadius: 40.0,
                          backgroundImage: NetworkImage(widget.avatarLink),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.width * 0.9,
                          left: MediaQuery.of(context).size.width * -0.095,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: islight
                                    ? Color(0xFFFFFFFC)
                                    : Color(0xFF002845),
                                shape: BoxShape.circle),
                          )),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.9,
                        right: MediaQuery.of(context).size.width * -0.095,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: islight
                                  ? Color(0xFFFFFFFC)
                                  : Color(0xFF002845),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
