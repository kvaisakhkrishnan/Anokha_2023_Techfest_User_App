import 'package:anokha_home/homeBody.dart';
import 'package:anokha_home/searchCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Loading_Screens/events_loading.dart';
import 'homeEventCard.dart';
import 'homePage.dart';

class SearchResults extends StatefulWidget {
  final List<events> list_of_events_organized;
  final int index;
  SearchResults({Key? key,
  required this.list_of_events_organized,
  required this.index}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {

  Future<List<events>> getEvents() async{
    List<events> filtered_events = [];


    //Required updation




    for (var event_data in list_of_events_organized){
      if(event_data.department == "CIE"){
        filtered_events.add(event_data);
      }
    }
    return filtered_events;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
          color: Colors.grey),
          onPressed: (){
            Navigator.pop(context);
          },

        ),
        elevation: 0,

      ),


        body: FutureBuilder(
          future: getEvents(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Events_Loading_screen();
            } else {
              List<events> filteredEvents = snapshot.data;
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 70,
                children: List.generate(filteredEvents.length, (index) {
                  events event = filteredEvents[index];
                  return SearchCard(event_data: filteredEvents[index]);
                }),
              );
            }
          },
        )








    );
  }
}
