import 'package:anokha_home/rowOfCards.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';
import 'anokhaCards.dart';

final String host = "http://18.182.1.81:3000";

class event_list {
  final int eventId;
  final String name;
  final String description;
  final String date;
  final int type;
  final String venue;
  final String time;
  final String department;
  final String day;

  event_list(
      {required this.eventId,
      required this.name,
      required this.description,
      required this.date,
      required this.type,
      required this.venue,
      required this.time,
      required this.department,
      required this.day});
}

class events_grouped_by_category {
  final String title;
  final List<event_list> events_list;

  events_grouped_by_category({required this.title, required this.events_list});
}

class HomeBody extends StatefulWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Future<List<events_grouped_by_category>> getEvents() async {
    String url = host + "/userApp/events/groupByDepartment";
    final token = 'v4.public.eyJ1c2VyRW1haWwiOiJjYi5lbi51NGNzZTIwMDEwQGNiLnN0dWRlbnRzLmFtcml0YS5lZHUiLCJwYXNzd29yZCI6IlNBRkVQQVNTV09SRDAiLCJpYXQiOiIyMDIzLTAzLTI3VDE4OjA4OjQxLjkzOFoiLCJleHAiOiIyMDIzLTAzLTI3VDE4OjIzOjQxLjkzOFoifRxY5sN5s31faWFKumLGZ3UQMIVqldd9qb4KUEk_2jSwad8qhkeX5SUd9n_8tVSD8_wp_J9EoBGLGAX8Aj4MgQw';
    final response = await http.get(
        Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'});
    var responseData = json.decode(response.body);
    List<events_grouped_by_category> list_of_events = [];
    for (var individual_data in responseData) {

      String temp_title = individual_data["department"];
      List<event_list> temp_event_list = [];
      for (var events_in_a_row in individual_data["events"]) {


        event_list temp_event_data = event_list(
            eventId: events_in_a_row["eventId"],
            name: events_in_a_row["eventName"],
            description: events_in_a_row["description"],
            date: events_in_a_row["date"],
            type: events_in_a_row["eventOrWorkshop"],
            venue: events_in_a_row["venue"],
            time: events_in_a_row["eventTime"],
            department: events_in_a_row["departmentAbbr"],
            day: events_in_a_row["date"]);



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
            itemCount: snapshot.data.length + 1, // add 1 for the static widget
            itemBuilder: (ctx, index) {
              if (index == 0) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, top: 20.0, bottom: 20.0),
                      child: AnokhaCards()
                    ),
                  ],
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
                          "${snapshot.data[index - 1].title}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    CardRow(
                      list_of_events: snapshot.data[index - 1].events_list,
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }

}