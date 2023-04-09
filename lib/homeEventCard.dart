import 'dart:convert';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'event_info.dart';
import 'homeBody.dart';
import 'login.dart';

final __url = serverUrl().url;

class EventCard extends StatefulWidget {
  final event_list event_data;
  var data;
  EventCard({Key? key, required this.event_data, required this.data}) : super(key: key);


  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {

  Future<void> addStarred(String url)async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.data.SECRET_TOKEN}',
      },
      body: jsonEncode({
        "eventId" : widget.event_data.eventId
      }),

    );
    if (response.statusCode == 200) {
      // Successful response
      print('POST request successful: ${response.body}');
    } else {
      // Error response
      print('POST request failed: ${response.statusCode} - ${response.body}');
    }
  }


  Future<void> removeStarred(String url)async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.data.SECRET_TOKEN}',
      },
      body: jsonEncode({
        "eventId" : widget.event_data.eventId
      }),

    );
    if (response.statusCode == 200) {
      // Successful response
      print('POST request successful: ${response.body}');
    } else {
      // Error response
      print('POST request failed: ${response.statusCode} - ${response.body}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: InkWell(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => EventInfo(event_map: {},)));

          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
              BoxShadow(
              color: Colors.grey,
              spreadRadius: 1.0,
              blurRadius: 10.0
          )
            ],
                  image: DecorationImage(
                    image: NetworkImage(widget.event_data.url),
                    fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
                ),
                constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.width * 0.4 * 1.0,
                  width: MediaQuery.of(context).size.width * 0.4
                ),


              ),
              Container(

                child:
              Row(

                children: [

                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.event_data.name,

                        style: TextStyle(
                          color: Color(0xFF002845),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),),
                        Text(widget.event_data.type == 0 ? "Event" : "Workshop" ,
                          style: TextStyle(
                          color: Color(0xFFFF7F11)
                          ),)
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,

                    ),
                  ),

                  Expanded(
                    child: widget.event_data.isStarred == 0 ? IconButton(
                        iconSize: 30.0,
                        alignment: Alignment.centerRight,
                        onPressed: (){
                          setState(() {
                            widget.event_data.isStarred = 1;
                          });
                          if(widget.event_data.isStarred == 1)
                            {
                              String url =  __url + "userApp/insertStarrs";
                              addStarred(url);
                            }


                        },
                        icon: Icon(
                            Icons.star_border,
                        ))
                    :
                    IconButton(
                        iconSize: 30.0,
                        color: Color(0xFFFF7F11),
                        alignment: Alignment.centerRight,
                        onPressed: (){
                          setState(() {
                            widget.event_data.isStarred  = 0;
                            if(widget.event_data.isStarred == 0)
                            {
                              String url =  __url + "userApp/dropStarrs";
                              removeStarred(url);
                            }
                          });
                        },
                        icon: Icon(
                            Icons.star
                        )),
                  )
                ],
              ),
                constraints: BoxConstraints.expand(
                    height: MediaQuery.of(context).size.width * 0.4 * 0.4,
                    width: MediaQuery.of(context).size.width * 0.4
                ),
                decoration: (
                BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1.0,
                      blurRadius: 10.0
                    )
                  ],
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))
                )
                ),

                )

            ],

    ),
        ),
      );
  }
}
