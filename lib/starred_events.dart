import 'dart:collection';

import 'package:anokha_home/event_info.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetStarrs extends StatefulWidget {
  var data = "";
  GetStarrs({Key? key, required this.data}) : super(key: key);

  @override
  State<GetStarrs> createState() => _GetStarrsState();
}

class _GetStarrsState extends State<GetStarrs> {
  String url = "http://52.66.236.118:3060/userApp/getStarredEvents";

  Future<Map<String, dynamic>> getData() async {
    final response = await http.get(Uri.parse(url),
        headers: {'authorization': 'Bearer ${widget.data}'});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
          future: getData(),
          builder: (context, ss) {
            if (ss.hasError) {
              print("error");
            }
            if (ss.hasData) {
              return Wheel(starr_map: ss.data);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

class Wheel extends StatefulWidget {
  Map<String, dynamic>? starr_map;

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
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Starred Events",
          style: GoogleFonts.dmSans(
              color: HexColor("#002845"), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: (widget.starr_map?.length == 0)
          ? Center(child: Text("You have not starred any events"))
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    child: New_Widget(index: index, starrs: widget.starr_map),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventInfo(
                                  event_map: widget.starr_map?[index])));
                    },
                  ),
                );
              }),
              itemCount: widget.starr_map?["nonstarredEvents"].length,
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
          borderRadius: BorderRadius.circular(30),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor("#193d57"), HexColor("#002845")]),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 150,
              width: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          widget.starrs!["nonstarredEvents"][widget.index]
                              ["name"],
                          maxLines: 4,
                          style: GoogleFonts.dmSans(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Image(
                          height: 100,
                          width: 100,
                          image:
                              AssetImage("images/anokha_2023_white_small.png"))
                    ],
                  ),
                  Text(
                    "${widget.starrs!["nonstarredEvents"][widget.index]["department"]} | ${widget.starrs!["nonstarredEvents"][widget.index]["type"]}",
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        color: HexColor("#FF7F11"),
                        fontSize: 25),
                  )
                ],
              )),
        ));
  }
}
