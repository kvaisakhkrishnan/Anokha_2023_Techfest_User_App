import 'package:anokha_home/rowOfCards.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';
import 'anokhaCards.dart';

final __url = serverUrl().url;

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
  final data;
  HomeBody({Key? key, required this.data}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Future<List<events_grouped_by_category>> getEvents() async {
    String url = __url + "userApp/events/groupByDepartment";
    final token = widget.data.SECRET_TOKEN;
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
            itemCount: snapshot.data.length + 2, // add 1 for the static widget
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
                  AnokhaCards()

                  ],
                );

              }

              else if(index == 1) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 20),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 19
                        ),

                        decoration: InputDecoration(
                          hintText: 'Search Events, Departments, Tags',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,

                        ),
                      ),
                    ),
                  ),
                );
              }


              else {
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
                              fontSize: 20.0, fontWeight: FontWeight.w500),
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