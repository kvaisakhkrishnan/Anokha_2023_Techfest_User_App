import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';

final __url = serverUrl().url;



class StarredEvents extends StatefulWidget {
  final data;
  const StarredEvents({Key? key, required this.data}) : super(key: key);
  @override
  State<StarredEvents> createState() => _StarredEvents();
}

class _StarredEvents extends State<StarredEvents> {
  Future<List> getData() async {
    String url = __url + "userApp/getStarredEvents";
    final token = widget.data.SECRET_TOKEN;
    final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'}
    );
    print("tokena :" +token);
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
          future: getData(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              print("error1");
            }
            if (snapshot.hasData) {
              return Wheel(list: snapshot.data);
            } else {
              return Events_Loading_screen();
            }
          }),
    );
  }
}

class Wheel extends StatefulWidget {
  List? list;
  Wheel({Key? key, required this.list}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Starred Events",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListWheelScrollView.useDelegate(
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("$index selected")));
        },
        itemExtent: MediaQuery.of(context).size.height * 0.26,
        perspective: 0.002,
        childDelegate: ListWheelChildBuilderDelegate(
            childCount: widget.list!.length,
            builder: (context, index) {
              return New_Widget(index: index);
            }),
      ),
    );
  }
}

class New_Widget extends StatelessWidget {
  int? index;
  New_Widget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(30),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 70,
              width: 320,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          "Eventide",
                          style: GoogleFonts.dmSans(fontSize: 30),
                        ),
                      ),
                      Image(
                          height: 120,
                          width: 120,
                          image:
                              AssetImage("Images/anokha_2023_black_small.png"))
                    ],
                  ),
                  Text(
                    "CSE | Workshop",
                    style:
                        GoogleFonts.dmSans(color: Colors.orange, fontSize: 20),
                  )
                ],
              )),
        ));
  }
}
