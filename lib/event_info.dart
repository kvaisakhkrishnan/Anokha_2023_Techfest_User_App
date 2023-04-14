import 'dart:collection';

import 'package:anokha_home/payments.dart';
import 'package:faded_widget/faded_widget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anokha_home/eventregistrationForm.dart';

import 'homePage.dart';

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
      body: jsonEncode({"eventId":widget.event_map.eventId}),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#002845"),
        body: Stack(
          children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 1,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Image(
                          fit: BoxFit.cover,
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
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.star,
                                            size: 30,
                                            color:
                                                (((widget.event_map.isStarred ==
                                                            1)) ||
                                                        liked == true)
                                                    ? Color(0xffff7f11)
                                                    : Colors.black,
                                          ),
                                          onPressed: () {
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
                                    style: TextStyle(
                                        backgroundColor: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0),
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
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                        style: TextStyle(
                                            color: Color(0xffbeb7a4),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
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
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
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
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  widget.event_map.description,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
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
            Padding(
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return PayU(
                                    data: widget.data,
                                    event_data: widget.event_map,
                                  );
                                }));
                              },
                              child: Center(
                                  child: Text("REGISTER",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#002845"),
                                          fontSize: 20))),
                            ),
                          ),
                        ),
                      ),
                    ))),
          ],
        ));
  }
}
