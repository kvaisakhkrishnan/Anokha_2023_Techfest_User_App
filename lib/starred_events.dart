import 'dart:collection';

import 'package:anokha_home/event_info.dart';
import 'package:anokha_home/serverUrl.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';

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
  Future<List> getData() async {
    String url = __url + "userApp/getStarredEvents";

    final response = await http.get(Uri.parse(url),
        headers: {'authorization': 'Bearer ${widget.data.SECRET_TOKEN}'});

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
          future: getData(),
          builder: (context, ss) {
            if (ss.hasError) {
              print(ss.error);
              print("error");
            }
            if (ss.hasData) {
              return Wheel(starr_map: ss.data);
            } else {
              return Events_Loading_screen();
            }
          }),
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
          ? Center(child: Text("You have not starred any events"))
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    child: New_Widget(
                        index: index, starrs: widget.starr_map![index]),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventInfo(
                                  event_map: null,
                                  data: token,
                                  star_map: widget.starr_map?[index])));
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
              height: MediaQuery.of(context).size.height * 0.26,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Starred Card",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
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
                            style: TextStyle(color: Color(0xffbeb7a4)),
                          ),
                          Text(widget.starrs!["eventName"],
                              style: TextStyle(color: Colors.black)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Date",
                            style: TextStyle(color: Color(0xffbeb7a4)),
                          ),
                          Text(widget.starrs!["date"],
                              style: TextStyle(color: Colors.black)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Venue",
                            style: TextStyle(color: Color(0xffbeb7a4)),
                          ),
                          Text(widget.starrs!["venue"],
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Event Type",
                            style: TextStyle(color: Color(0xffbeb7a4)),
                          ),
                          Text(
                              widget.starrs!["eventOrWorkshop"] == 0
                                  ? "Event"
                                  : "Workshop",
                              style: TextStyle(color: Colors.black)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            "Time",
                            style: TextStyle(color: Color(0xffbeb7a4)),
                          ),
                          Text(widget.starrs!["eventTime"],
                              style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
