import 'package:anokha_home/rowOfCards.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';
import 'anokhaCards.dart';

final __url = serverUrl().url;





class HomeBody extends StatefulWidget {

  final data;
  var eventsList;
  HomeBody({Key? key, required this.data, required this.eventsList}) : super(key: key);


  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {


  void search(String search) {
    if (search == "") {

    }
    else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.eventsList.length + 1,
      itemBuilder: (ctx, index) {
        if (index == 0) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 20.0, bottom: 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Trending Now",
                    style: TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              AnokhaCards(),
            ],
          );
        } else if (index == 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0, horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10, top: 3, bottom: 3, right: 20),
                child: TextFormField(
                  onChanged: (value) {
                    search(value);
                  },
                  style: TextStyle(fontSize: 19),
                  decoration: InputDecoration(
                    hintText: 'Search Events, Departments, Tags',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, top: 20.0, bottom: 20.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${widget.eventsList[index - 2].title}",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              CardRow(
                list_of_events:
                widget.eventsList[index - 2].events_list,
              ),
            ],
          );
        }
      },
    );
  }
}