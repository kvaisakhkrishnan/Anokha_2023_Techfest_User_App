import 'package:anokha_home/rive_assets.dart';
import 'package:anokha_home/rowOfCards.dart';
import 'package:anokha_home/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'animated_bar.dart';
import 'homeBody.dart';
import 'homeEventCard.dart';




class events {
  final int eventId;
  final String name;
  final String description;
  final String date;
  final int type;
  final String venue;
  final String time;
  final String department;
  final String day;
  final int technical;
  final int noOfRegistrations;
  final String url;
  final int individualOrGroup;
  final int maxCount;
  int isStarred;

  events(
      {required this.eventId,
        required this.name,
        required this.description,
        required this.date,
        required this.type,
        required this.venue,
        required this.time,
        required this.department,
        required this.day,
        required this.technical,
        required this.noOfRegistrations,
        required this.url,
        required this.individualOrGroup,
        required this.maxCount,
        required this.isStarred});
}

class HomeWidget extends StatefulWidget {
  var data;

  var eventsList;
  HomeWidget({Key? key, required this.data, required this.eventsList}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 0.0,

        ),
        body: HomeBody(data: widget.data, eventsList: widget.eventsList));
  }
}
