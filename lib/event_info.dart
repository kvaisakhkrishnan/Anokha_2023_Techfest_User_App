import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'package:anokha_home/Loading_Screens/events_loading.dart';
import 'package:anokha_home/payments.dart';
import 'package:faded_widget/faded_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shimmer/shimmer.dart';
import 'buyPassport.dart';
import 'homePage.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';




//This page shows complete information of various events and workshops that were organized.

class EventInfo extends StatefulWidget {
  bool txt_visible = false;
  var event_map;
  var data;

  EventInfo({Key? key, required this.event_map, this.data}) : super(key: key) {
    txt_visible = true;
  }

  @override
  State<EventInfo> createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  ScrollController _controller = ScrollController();
  bool liked = false;

  Color bg = HexColor("#000000");

  void _onScrollEvent() {}

  @override
  void initState() {
    _controller.addListener(_onScrollEvent);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollEvent);
    super.dispose();
  }




  Future<void> _addStarred() async {

    final String url = "https://anokha.amrita.edu/api/userApp/insertStarrs";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.data.SECRET_TOKEN}',
      },
      body: jsonEncode({"eventId": widget.event_map.eventId}),
    );
    if (response.statusCode == 200) {
      // Successful response
      print('POST request successful: ${response.body}');
    } else {
      // Error response
      print('POST request failed: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> _deleteStarred() async {
    final String url = "https://anokha.amrita.edu/api/userApp/dropStarrs";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.data.SECRET_TOKEN}',
      },
      body: jsonEncode({"eventId": widget.event_map.eventId}),
    );
    if (response.statusCode == 200) {
      // Successful response
      print('POST request successful: ${response.body}');
    } else {
      // Error response
      print('POST request failed: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> shareImageUrl(String imageUrl) async {
    try {
      // Download the image
      final response = await http.get(Uri.parse(widget.event_map.url));

      print(response.statusCode);

      if (response.statusCode == 200) {
        // Get the temporary directory to store the image


        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        var rng = new Random();
        File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
        // Create a temporary file with a random name and '.png' extension

        // Write the downloaded image data to the temporary file
        await file.writeAsBytes(response.bodyBytes);

        // Share the image using the file path
        await Share.shareFiles([file.path], text: 'Take a look at the ${widget.event_map.name} organized by Anokha 2023 at Amrita Vishwa Vidyapeetham, Coimbatore Campus on ${widget.event_map.date}. Do check it out at Anokha 2023 App by following this link https://play.google.com/store/apps/details?id=com.vaisakhkrishnank.anokha_home or the Anokha official website https://anokha.amrita.edu/');


         }
      else {
        throw Exception('Failed to download the image.');
      }
    } catch (e) {
      print('Error sharing image: $e');
    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#002845"),
        body:

        Stack(
          children: [

            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 1,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(widget.event_map.url)),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 90),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: HexColor("#FFFFFC")),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      color: HexColor("#FFFFFC")),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: NotificationListener(
                      /*child: Scrollbar(
                          isAlwaysShown: false,
                          controller: _controller,
                          showTrackOnHover: true,*/
                      child: SingleChildScrollView(
                        controller: _controller,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            10.0, 0.0, 40.0, 10.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            widget.event_map.name,
                                            maxLines: 3,
                                            style: GoogleFonts.dmSans(textStyle: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.06,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff002845)
                                            )),
                                          ),
                                        ),
                                      ),


                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.ios_share_rounded,
                                            size: 25,

                                          ),
                                          onPressed: () {
                                            shareImageUrl(widget.event_map.url);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [

                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                  ),
                                  Text(
                                    "₹${widget.event_map.fees}",
                                    style:GoogleFonts.dmSans(textStyle:  TextStyle(
                                      color: Color(0xff002845),
                                        backgroundColor: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          color: Color(0xffff7f11),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Row(children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.001,
                                              ),
                                              Text(
                                                "Location",
                                                style: GoogleFonts.dmSans(textStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        widget.event_map.venue,
                                        maxLines: 3,
                                        style: GoogleFonts.dmSans(textStyle: TextStyle(
                                            color: Color(0xffbeb7a4),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Material(
                                    color: HexColor("#002845"),
                                    elevation: 10,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 10, 10),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${(widget.event_map.totalNumberOfSeats)}\nTotal Seats",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.dmSans(textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Material(
                                    color: HexColor("#002845"),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 10, 10, 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${widget.event_map.date}\n${widget.event_map.time}",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.dmSans(textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0, left: 15, right: 15, bottom: 25),
                                child: MarkdownBody(
                                  data: widget.event_map.description,
                                  styleSheet: MarkdownStyleSheet.fromTheme(
                                          Theme.of(context))
                                      .copyWith(
                                    h1: GoogleFonts.dmSans(textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    h2: GoogleFonts.dmSans(textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    h3:GoogleFonts.dmSans(textStyle:  TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    h4: GoogleFonts.dmSans(textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    h5:GoogleFonts.dmSans(textStyle:  TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
                                    h6: GoogleFonts.dmSans(textStyle: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onNotification: (notificationInfo) {
                        if (notificationInfo is ScrollStartNotification) {
                          setState(() {
                            widget.txt_visible = true;
                            print("${widget.txt_visible}");
                          });

                          /// your code
                        }
                        return true;
                      }),
                ),
              ),
            ),
            SizedBox(height: 0),
            (widget.event_map.totalNumberOfSeats > widget.event_map.noOfRegistrations) ? Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.9, 0, 0),
                child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#002845"),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Visibility(
                        visible: widget.txt_visible,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Container(
                            decoration: ShapeDecoration(
                                shape: StadiumBorder(), color: Colors.white),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: HexColor("#002845"),
                                backgroundColor:
                                Colors.white, // Background color
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20), // Padding
                                textStyle:
                                TextStyle(fontSize: 30), // Text style
                                shape: RoundedRectangleBorder(
                                  // Button shape
                                  borderRadius: BorderRadius.circular(15),
                                  side:
                                  BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                              onPressed: () {
                                if (widget.data.activePassport == 1) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return PayU(
                                          data: widget.data,
                                          event_data: widget.event_map,
                                        );
                                      }));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(25)),
                                          title: Text('Buy Passport'),
                                          content: Text(
                                              'You have to buy a passport to view events'),
                                          actions: [
                                            TextButton(
                                              child: Text('Buy Passport',
                                                  style: TextStyle(
                                                      color:
                                                      Color(0xff002845))),
                                              onPressed: () {
                                                // Close the pop-up notification
                                                Navigator.of(context).pop();

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PassportBuy(
                                                                data: widget
                                                                    .data)));
                                              },
                                            ),
                                            TextButton(
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                // Close the pop-up notification
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                              child: Center(
                                  child: Text("REGISTER",
                                      style:GoogleFonts.dmSans(textStyle:  TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#002845"),
                                          fontSize: 20)))),
                            ),
                          ),
                        ),
                      ),
                    ))) : Padding(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height * 0.9, 0, 0),
                child: Container(
                    decoration: BoxDecoration(
                        color: HexColor("#002845"),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Center(
                      child: Visibility(
                        visible: widget.txt_visible,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Container(
                            decoration: ShapeDecoration(
                                shape: StadiumBorder(), color: Colors.white),
                            child: TextButton(

                              style: TextButton.styleFrom(
                                foregroundColor: HexColor("#002845"),
                                backgroundColor:
                                Colors.white, // Background color
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20), // Padding
                                textStyle:
                                TextStyle(fontSize: 30), // Text style
                                shape: RoundedRectangleBorder(
                                  // Button shape
                                  borderRadius: BorderRadius.circular(15),
                                  side:
                                  BorderSide(color: Colors.black, width: 2),
                                ),
                              ),
                            onPressed: (){
                            },
                              child: Center(
                                  child: Text("HOUSE FULL",
                                      style:GoogleFonts.dmSans(textStyle:  TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#002845"),
                                          fontSize: 20)))),
                            ),
                          ),
                        ),
                      ),
                    ))),




          ],
        ));
  }
}
