import 'package:anokha_home/rive_assets.dart';
import 'package:anokha_home/rowOfCards.dart';
import 'package:anokha_home/searchResults.dart';
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
  final String type;
  final String venue;
  final String startTime;
  final String endTime;
  final String department;
  final String day;

  events(
      {required this.eventId,
      required this.name,
      required this.description,
      required this.date,
      required this.type,
      required this.venue,
      required this.startTime,
      required this.endTime,
      required this.department,
      required this.day});
}


class HomeWidget extends StatefulWidget {
  HomeWidget({Key? key}) : super(key: key);

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

        ),
        body: HomeBody());
  }
}
