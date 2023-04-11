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
  EventCard({Key? key, required this.event_data, required this.data})
      : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  Future<void> addStarred(String url) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.data.SECRET_TOKEN}',
      },
      body: jsonEncode({"eventId": widget.event_data.eventId}),
    );
    if (response.statusCode == 200) {
      // Successful response
      print('POST request successful: ${response.body}');
    } else {
      // Error response
      print('POST request failed: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> removeStarred(String url) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.data.SECRET_TOKEN}',
      },
      body: jsonEncode({"eventId": widget.event_data.eventId}),
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventInfo(
                      event_map: widget.event_data, data: widget.data)));
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 1.0, blurRadius: 10.0)
                  ],
                  image: DecorationImage(
                      image: NetworkImage(widget.event_data.url),
                      fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.width * 0.4 * 1.0,
                  width: MediaQuery.of(context).size.width * 0.42),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10.0, top: MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event_data.name,
                      style: TextStyle(
                        color: Color(0xFF002845),
                        fontSize: 19.0,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                    Row(
                      children: [
                        Text(
                          widget.event_data.type == 0 ? "Event" : "Workshop",
                          style: TextStyle(
                            color: Color(0xFFFF7F11),
                            fontSize: 17.0,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          iconSize: 30.0,
                          color: widget.event_data.isStarred == 1
                              ? Color(0xFFFF7F11)
                              : null,
                          onPressed: () {
                            setState(() {
                              widget.event_data.isStarred =
                                  1 - widget.event_data.isStarred;
                              String url = __url +
                                  (widget.event_data.isStarred == 1
                                      ? "userApp/insertStarrs"
                                      : "userApp/dropStarrs");
                              if (widget.event_data.isStarred == 1) {
                                addStarred(url);
                              } else {
                                removeStarred(url);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.star_border,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.width * 0.4 * 0.6,
                  width: MediaQuery.of(context).size.width * 0.42),
              decoration: (BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)),
              )),
            )
          ],
        ),
      ),
    );
  }
}
