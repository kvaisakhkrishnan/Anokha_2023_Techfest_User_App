import 'package:anokha_home/login.dart';
import 'package:anokha_home/rowOfCards.dart';
import 'package:anokha_home/searchCard.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';
import 'anokhaCards.dart';
import 'homeEventCard.dart';

final __url = serverUrl().url;

class HomeBody extends StatefulWidget {
  final data;
  var eventsList;
  HomeBody({Key? key, required this.data, required this.eventsList})
      : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var searchInitiated = 0;
  List<event_list> eventsSearch = [];
  void search(String search) {
    if (search.isEmpty) {
      setState(() {
        searchInitiated = 0;
      });
    } else {
      eventsSearch = [];
      for (var eventUnderDept in widget.eventsList) {
        if (eventUnderDept.title.toLowerCase().contains(search.toLowerCase())) {
          for (var eventDetail in eventUnderDept.events_list) {
            eventsSearch.add(eventDetail);
          }
          continue;
        }

        for (var eventDetail in eventUnderDept.events_list) {
          if (eventDetail.eventId
                  .toString()
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              eventDetail.name.toLowerCase().contains(search.toLowerCase()) ||
              eventDetail.description
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              eventDetail.date.toLowerCase().contains(search.toLowerCase()) ||
              eventDetail.venue.toLowerCase().contains(search.toLowerCase()) ||
              eventDetail.department
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              eventDetail.day.toLowerCase().contains(search.toLowerCase())) {
            eventsSearch.add(eventDetail);
          }
        }
      }
      setState(() {
        searchInitiated = 1;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 20),
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
              ),
            ],
          ),
        ),
        if (searchInitiated == 0)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${widget.eventsList[index].title}",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    CardRow(
                      list_of_events: widget.eventsList[index].events_list,
                    ),
                  ],
                );
              },
              childCount: widget.eventsList.length,
            ),
          ),
        if (searchInitiated == 1) _buildSearchGridView(eventsSearch),
      ],
    );
  }

  Widget _buildSearchGridView(List<event_list> eventsSearch) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return _buildEventCard(eventsSearch[index]);
          },
          childCount: eventsSearch.length,
        ),
      ),
    );
  }

  Widget _buildEventCard(event_list event) {
    return EventCard(event_data: event);
  }
}
