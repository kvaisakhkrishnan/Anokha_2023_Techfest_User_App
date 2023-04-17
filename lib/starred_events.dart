import 'dart:collection';

import 'package:anokha_home/SessionExpired/sessionExpired.dart';
import 'package:anokha_home/event_info.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';
import 'homePage.dart';

final __url = serverUrl().url;
var token;

class GetStarrs extends StatefulWidget {
  var data;
  GetStarrs({Key? key, required this.data}) : super(key: key) {
    token = data;
  }

  @override
  State<GetStarrs> createState() => _GetStarrsState();
}

class _GetStarrsState extends State<GetStarrs> {
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

  Future<List> getData() async {
    String url = __url + "userApp/getStarredEvents";

    final response = await http.get(Uri.parse(url),
        headers: {'authorization': 'Bearer ${widget.data.SECRET_TOKEN}'});
    if (response.statusCode == 401) {
      return ["SESSIONEXPIRATIONERROR"];
    }
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: FutureBuilder<List>(
            future: getData(),
            builder: (context, ss) {
              if (ss.hasError) {}
              if (ss.hasData) {
                if (listEquals(ss.data, ["SESSIONEXPIRATIONERROR"])) {
                  return SessionExpired();
                } else {
                  return Wheel(starr_map: ss.data);
                }
              } else {
                return Events_Loading_screen();
              }
            }),
      ),
    );
  }
}

class Wheel extends StatefulWidget {
  List? starr_map;

  Wheel({Key? key, required this.starr_map}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  final _scrollController = FixedExtentScrollController();
  late BuildContext ctx1;
  @override
  Widget build(BuildContext context) {
    ctx1 = context;
    return Scaffold(
      backgroundColor: Color(0xff002845),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Color(0xff002845),
        centerTitle: true,
      ),
      body: (widget.starr_map?.length == 0)
          ? Center(
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

                children: [Text(
                "404",
                style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffbeb7a4), fontSize: MediaQuery.of(context).size.width * 0.2)),
                maxLines: 3,
              ),

                Text("No Starred Events",
                style: GoogleFonts.dmSans(
                  textStyle: TextStyle(color:Colors.white, fontSize: 18 )
                ),)]),
          )
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    child: New_Widget(
                        index: index, starrs: widget.starr_map![index]),
                    onTap: () {
                   print( widget.starr_map![index]["type"]);
                      var event_map = events(
                          totalNumberOfSeats: widget.starr_map![index]
                              ["totalNumberOfSeats"],
                          eventId: widget.starr_map![index]["eventId"],
                          date: widget.starr_map![index]["date"],
                          day: "",
                          department: widget.starr_map![index]
                              ["departmentAbbr"],
                          description: widget.starr_map![index]["description"],
                          fees: widget.starr_map![index]["fees"],
                          individualOrGroup: widget.starr_map![index]
                              ["groupOrIndividual"],
                          isStarred: 1,
                          maxCount: widget.starr_map![index]["maxCount"],
                          name: widget.starr_map![index]["eventName"],
                          noOfRegistrations: widget.starr_map![index]
                              ["noOfRegistrations"],
                          technical: widget.starr_map![index]["technical"],
                          time: widget.starr_map![index]["eventTime"],
                          type: widget.starr_map![index]["eventOrWorkshop"],
                          url: widget.starr_map![index]["url"],
                          venue: widget.starr_map![index]["venue"]);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventInfo(
                                    event_map: event_map,
                                    data: token,
                                  )));
                    },
                  ),
                );
              }),
              itemCount: widget.starr_map?.length,
              /*child: ListWheelScrollView.useDelegate(
                physics: FixedExtentScrollPhysics(),
                itemExtent: MediaQuery.of(context).size.height * 0.26,
                perspective: 0.001,
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.starr_map?["nonstarredEvents"].length,
                    builder: (context, index) {
                      return New_Widget(index: index, starrs: widget.starr_map);
                    }),
              ),*/
            ),
    );
  }
}

class New_Widget extends StatefulWidget {
  int? index;
  Map<String, dynamic>? starrs;
  New_Widget({Key? key, required this.index, this.starrs}) : super(key: key);

  @override
  State<New_Widget> createState() => _New_WidgetState();
}

class _New_WidgetState extends State<New_Widget> {
  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(40),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: MediaQuery.of(context).size.height * 0.27,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Starred Card",
                          style: GoogleFonts.dmSans(textStyle:  TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.height * 0.021,
                              fontWeight: FontWeight.w500)),
                        ),
                        Image(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.2,
                            image: AssetImage(
                                "Images/anokha_2023_black_small.png"))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Event Name",
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffbeb7a4), fontSize: MediaQuery.of(context).size.height * 0.015)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(widget.starrs!["eventName"],
                                style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.015)),
                                maxLines: 2,
                                overflow: TextOverflow.fade,),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Date",
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffbeb7a4), fontSize: MediaQuery.of(context).size.height * 0.015)),
                          ),
                          Text(widget.starrs!["date"],
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.015))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Venue",
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffbeb7a4), fontSize: MediaQuery.of(context).size.height * 0.015)),
                          ),
                          Text(widget.starrs!["venue"],
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.015))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Event Type",
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffbeb7a4), fontSize: MediaQuery.of(context).size.height * 0.015)),
                          ),
                          Text(
                              widget.starrs!["eventOrWorkshop"] == 0
                                  ? "Event"
                                  : "Workshop",
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.015))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Time",
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffbeb7a4), fontSize: MediaQuery.of(context).size.height * 0.015)),
                          ),
                          Text(widget.starrs!["eventTime"],
                            style: GoogleFonts.dmSans(textStyle: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.015))),
                        ],
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

}
