import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'event_info.dart';
import 'homeBody.dart';
import 'login.dart';

class EventCard extends StatefulWidget {
  final event_list event_data;

  EventCard({Key? key, required this.event_data}) : super(key: key);


  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool starred = false;
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
                    child: !starred? IconButton(
                        iconSize: 30.0,
                        alignment: Alignment.centerRight,
                        onPressed: (){
                          setState(() {
                            starred  = !starred;
                          });
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
                            starred  = !starred;
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
