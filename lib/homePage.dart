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


final String host = "http://18.183.52.0:3060";

List<String> search_match = [];

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



List<events> list_of_events_organized = [];


class HomeWidget extends StatefulWidget {
  String gravatar_url;
  HomeWidget({Key? key,
  required this.gravatar_url}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {


  Future<void> get_events_list() async{
    String url = host + "/api/events/all";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    for(var individual_event in responseData){
      events temp_event = events(
          eventId: individual_event["eventId"],
          name: individual_event["name"],
          description: individual_event["description"],
          date: individual_event["date"],
          type: individual_event["type"],
          venue: individual_event["venue"],
          startTime: individual_event["startTime"],
          endTime: individual_event["endTime"],
          department: individual_event["department"],
          day: individual_event["day"]);
      list_of_events_organized.add(temp_event);


    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [


          Padding(
            child:
            GestureDetector(
              child: Icon(Icons.search,
                size: 30.0,
                color: Color(0xFF002845),
              ),
              onTap: (){

                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate());
                get_events_list();

              },
            )
              ,
            padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0)
          ),



          GestureDetector(
            onTap: (){

            },
            child: Padding(
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.gravatar_url),
              ),
              padding:  EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),

            ),
          )
        ],
      ),
      body: HomeBody()

















    );
  }


}



class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "Popular Events",
    "Day 1 Events",
    "Day 2 Events",
    "Day 3 Events",
    "AEE Department",
    "AIE Department",
    "ARE Department",
    "CCE Department",
    "CHE Department",
    "CIE Department",
    "CVI Department",
    "CSE Department",
    "CYS Department",
    "EAC Department",
    "ECE Department",
    "EEE Department",
    "EIE Department",
    "ELC Department",
    "MEE Department"
  ];

  String _query = '';

  set query(String value) {
    _query = value;
  }

  void _onQueryChanged() {

  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      SizedBox()
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here based on the current query
    return ListView.builder(
      itemCount: searchTerms.length,
      itemBuilder: (context, index){
        var result = searchTerms[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged();

    // Implement your search suggestions here based on the current query
    return ListView.builder(
      itemCount: searchTerms.length,
      itemBuilder: (context, index){
        var result = searchTerms[index];
        return TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  SearchResults(list_of_events_organized: list_of_events_organized, index: index)));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(result,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17,

                ),),
              ),
            ));
      },
    );
  }
}




