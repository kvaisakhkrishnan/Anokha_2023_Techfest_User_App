import 'package:anokha_home/login.dart';
import 'package:anokha_home/rowOfCards.dart';
import 'package:anokha_home/searchCard.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';
import 'anokhaCards.dart';
import 'homeEventCard.dart';

//This page shows lst if all events in a tile format.
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
  var allEvents = [];
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
              eventDetail.description.toLowerCase().contains(search.toLowerCase()) ||
              eventDetail.date.toLowerCase().contains(search.toLowerCase()) ||
              (search.toLowerCase().contains("event") && eventDetail.type == 0) ||
              (search.toLowerCase().contains("workshop") && eventDetail.type == 1) ||
              (search.toLowerCase().contains("individual") && eventDetail.individualOrGroup == 0) ||
              (search.toLowerCase().contains("single") && eventDetail.individualOrGroup == 0) ||

              (search.toLowerCase().contains("group") && eventDetail.individualOrGroup == 1) ||
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

  void sortEventsByRegistrations() {
    allEvents
        .sort((a, b) => b.noOfRegistrations.compareTo(a.noOfRegistrations));
  }

  var eventideCount = -1;

  @override
  void initState() {
    var count = 0;
    for (var eventsUnderDept in widget.eventsList) {
      if(eventsUnderDept.title == "Eventide")
        {
          eventideCount = count;
        }
      count += 1;
      for (var eventDetail in eventsUnderDept.events_list) {
        allEvents.add(eventDetail);
      }
    }
    sortEventsByRegistrations();




  }



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
                        style: GoogleFonts.dmSans(textStyle: TextStyle(
                            color: Color(0xffbeb7a4),
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  AnokhaCards(data: allEvents, token: widget.data),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff002845),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color(
                          0xffbeb7a4), // set the desired border color here
                      width: 2.0, // set the desired border width here
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 20),
                    child: TextFormField(
                      onChanged: (value) {
                        search(value);
                      },
                      style: TextStyle(fontSize: 18, color: Color(0xffbeb7a4)),
                      decoration: InputDecoration(
                        hintText: 'Search Events, Departments',
                        hintStyle: GoogleFonts.dmSans(textStyle: TextStyle(
                          color: Color(
                              0xffbeb7a4), // set the desired hint text color here
                        )),
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
               if(index == 0)
                 {
                   return Column(
                     children: [
                       Padding(
                         padding:
                         EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                         child: Container(
                           alignment: Alignment.topLeft,
                           child: Text(
                             "Event - Eventide",
                             style: GoogleFonts.dmSans(textStyle: TextStyle(
                                 color: Color(0xffbeb7a4),
                                 fontSize: 20.0,
                                 fontWeight: FontWeight.w500)),
                           ),
                         ),
                       ),
                       CardRow(
                           list_of_events: widget.eventsList[eventideCount].events_list,
                           data: widget.data),
                     ],
                   );
                 }
               else if(index < eventideCount){
                 return Column(
                   children: [
                     Padding(
                       padding:
                       EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                       child: Container(
                         alignment: Alignment.topLeft,
                         child: Text(
                           "${widget.eventsList[index-1].title}",
                           style: GoogleFonts.dmSans(textStyle: TextStyle(
                               color: Color(0xffbeb7a4),
                               fontSize: 20.0,
                               fontWeight: FontWeight.w500)),
                         ),
                       ),
                     ),
                     CardRow(
                         list_of_events: widget.eventsList[index-1].events_list,
                         data: widget.data),
                   ],
                 );
               }
               else{
                 return Column(
                   children: [
                     Padding(
                       padding:
                       EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
                       child: Container(
                         alignment: Alignment.topLeft,
                         child: Text(
                           "${widget.eventsList[index].title}",
                           style: GoogleFonts.dmSans(textStyle: TextStyle(
                               color: Color(0xffbeb7a4),
                               fontSize: 20.0,
                               fontWeight: FontWeight.w500)),
                         ),
                       ),
                     ),
                     CardRow(
                         list_of_events: widget.eventsList[index].events_list,
                         data: widget.data),
                   ],
                 );
               }
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
          childAspectRatio: 4 / 7,
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
    return EventCard(
      event_data: event,
      data: widget.data,
    );
  }
}
