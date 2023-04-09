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

class GetStarrs extends StatefulWidget {
  var data;
  GetStarrs({Key? key, required this.data}) : super(key: key);

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
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
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
                    child: New_Widget(
                        index: index, starrs: widget.starr_map![index]),
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
          borderRadius: BorderRadius.circular(30),
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff002845),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          widget.starrs!["eventName"],
                          maxLines: 4,
                          style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Image(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.25,
                          image:
                              AssetImage("Images/anokha_2023_white_small.png"))
                    ],
                  ),
                  Text(
                    "${widget.starrs!["date"]}",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.dmSans(
                        color: HexColor("BEB7A4"), fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "${widget.starrs!["departmentabbr"]} | ${widget.starrs!["venue"]}",
                    style: GoogleFonts.dmSans(
                        color: HexColor("#FF7F11"), fontSize: 20),
                  )
                ],
              )),
        ));
  }
}
