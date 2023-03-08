import 'package:flutter/material.dart';

class userProf extends StatefulWidget {
  String avatarLink;
  userProf({Key? key,
  required this.avatarLink}) : super(key: key);

  @override
  State<userProf> createState() => _userProfState();
}

class _userProfState extends State<userProf> {
  bool islight = true;

  refresh() {
    setState(() {
      if (islight)
        islight = false;
      else
        islight = true;
    });
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

    return Scaffold(
        backgroundColor: islight ? Color(0xFFFFFFFC) : Color(0xFF002845),
        appBar: AppBar(

          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Container(
              alignment: Alignment.centerLeft,
              child: themeChangeIcon(notifyParent: refresh),
            ),
            IconButton(
              onPressed: () {},
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
                    top: MediaQuery.of(context).size.height * 0.00, left: MediaQuery.of(context).size.width * 0.09, right: MediaQuery.of(context).size.width * 0.09, bottom: MediaQuery.of(context).size.height * 0.01),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.height * 0.5,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: islight ? Color(0xFF002845) : Color(0xFFFFFFFC),
                      ),
                      // color: Colors.black,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Image(image: AssetImage('Images/anokha_circle.png'),),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                              child: Text(
                                "PASSPORT",
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: islight
                                        ? Color(0xFFFFFFFC)
                                        : Color(0xFF002845),
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.004),
                                alignment: Alignment.topCenter,
                                child: Divider(
                                  color: islight
                                      ? Color(0xFFFFFFFC)
                                      : Color(0xFF002845),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                              child: Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: islight
                                        ? Color(0xFFFFFFFC)
                                        : Color(0xFF002845),
                                    fontFamily: "Roboto"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                              child: Text(
                                "name@gmail.com",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: islight
                                        ? Color(0xFFFFFFFC)
                                        : Color(0xFF002845),
                                    fontFamily: "Roboto"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                              child: Text(
                                "Account Balance",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: islight
                                        ? Color(0xFFFFFFFC)
                                        : Color(0xFF002845),
                                    fontFamily: "Roboto"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
                              child: Text.rich(
                                TextSpan(
                                    text: "₹",
                                    style: (TextStyle(
                                        fontSize: 35.0,
                                        color: islight
                                            ? Color(0xFFFFFFFC)
                                            : Color(0xFF002845),
                                        fontFamily: "Roboto")),
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: "0.0",
                                          style: TextStyle(
                                              fontSize: 27,
                                              color: Color(0xFFFF7F11)))
                                    ]),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.22,
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
                                            ? Color(0xFFFFFFFC)
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
                      right: MediaQuery.of(context).size.width * -0.095,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color:
                            islight ? Color(0xFFFFFFFC) : Color(0xFF002845),
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class themeChangeIcon extends StatefulWidget {
  final Function() notifyParent;
  const themeChangeIcon({Key? key, required this.notifyParent})
      : super(key: key);

  @override
  State<themeChangeIcon> createState() => _themeChangeIconState();
}

class _themeChangeIconState extends State<themeChangeIcon> {
  bool lightTheme = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: lightTheme
            ? Icon(
          Icons.sunny,
          // color: Colors.white,
        )
            : Icon(Icons.nightlight, color: Colors.black),
        onPressed: () {
          widget.notifyParent();
          setState(() {
            if (lightTheme)
              lightTheme = false;
            else
              lightTheme = true;
          });
        },
      ),
    );
  }
}
