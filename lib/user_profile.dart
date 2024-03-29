import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

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


//Profile page which displays the users details and passport.2
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
            child: Center(
              child: QrImage(

                foregroundColor : Colors.black,
                data: "https://anokha.amrita.edu/api/adminApp/verifyUser/${widget.data.userEmail}",
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.height * 0.19,
                gapless: false,

                embeddedImageStyle: QrEmbeddedImageStyle(
                  size: Size(MediaQuery.of(context).size.height * 0.05, MediaQuery.of(context).size.height * 0.05),
                ),
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Please Conatct User App Developers",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
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
            automaticallyImplyLeading: false,
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
                                  style: GoogleFonts.dmSans(textStyle: TextStyle(
                                    fontSize: 25.0,
                                    color: islight
                                        ? Color(0xFFBEB7AA)
                                        : Color(0xFF002845),
                                  )),
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
                                  style: GoogleFonts.dmSans(textStyle: TextStyle(
                                    fontSize: 0.027 *
                                        MediaQuery.of(context).size.height,
                                    color: islight
                                        ? Color(0xFFFFFFFC)
                                        : Color(0xFF002845),
                                  )),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
                                child: Text(
                                  widget.data.userEmail,
                                  style: GoogleFonts.dmSans(textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 0.018 *
                                          MediaQuery.of(context).size.height,
                                      color: islight
                                          ? Color(0xFFBEB7AA)
                                          : Color(0xFF002845))),
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
                                                    PassportBuy(
                                                  data: widget.data,
                                                ),
                                              ));
                                        },
                                        child: Text("Buy Passport",
                                        style: GoogleFonts.dmSans(),),
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          primary: Color(0xff002845),
                                        ),
                                      ))
                                  : Padding(
                                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                    child: Text("Passport Id: ${widget.data.passportId}",
                              style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffff7f11),
                                  fontWeight: FontWeight.w500)),),
                                  ),
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
                                      child:  Padding(
                                        padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height * 0.02,),
                                        child: QrImage(
                                          foregroundColor : Color(0xff002845),
                                          data: "https://anokha.amrita.edu/api/adminApp/verifyUser/${widget.data.userEmail}",
                                          version: QrVersions.auto,
                                          size: MediaQuery.of(context).size.height * 0.19,
                                          gapless: false,

                                          embeddedImageStyle: QrEmbeddedImageStyle(
                                            size: Size(MediaQuery.of(context).size.height * 0.05, MediaQuery.of(context).size.height * 0.05),
                                          ),
                                          errorStateBuilder: (cxt, err) {
                                            return Container(
                                              child: Center(
                                                child: Text(
                                                  "Please Conatct User App Developers",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
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
