import 'package:anokha_home/rowOfCards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';

String host = "http://18.183.52.0:3060";

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

class events_grouped_by_category {
  final String title;
  final List<events> events_list;

  events_grouped_by_category({required this.title, required this.events_list});
}

class HomeBody extends StatefulWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Future<List<events_grouped_by_category>> getEvents() async {
    String url = host + "/api/events/all/groupbydepartment";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    List<events_grouped_by_category> list_of_events = [];
    for (var individual_data in responseData) {
      String temp_title = individual_data["department"];
      List<events> temp_event_list = [];
      for (var events_in_a_row in individual_data["events"]) {
        events temp_event_data = events(
            eventId: events_in_a_row["eventId"],
            name: events_in_a_row["name"],
            description: events_in_a_row["description"],
            date: events_in_a_row["date"],
            type: events_in_a_row["type"],
            venue: events_in_a_row["venue"],
            startTime: events_in_a_row["startTime"],
            endTime: events_in_a_row["endTime"],
            department: events_in_a_row["department"],
            day: events_in_a_row["day"]);
        temp_event_list.add(temp_event_data);
      }
      events_grouped_by_category temp_data_row = events_grouped_by_category(
          title: temp_title, events_list: temp_event_list);
      list_of_events.add(temp_data_row);
    }
    return list_of_events;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getEvents(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Events_Loading_screen();
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (ctx, index) {
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${snapshot.data[index].title} Department",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    CardRow(
                      list_of_events: snapshot.data[index].events_list,
                    ),
                  ],
                );
              });
        }
      },
    );
  }
}
