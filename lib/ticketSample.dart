import 'dart:convert';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'Loading_Screens/events_loading.dart';
import 'homePage.dart';





class MyTicketView extends StatelessWidget {
  var data;
  var event;
  MyTicketView({Key? key, required this.data, required this.event}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return TicketWidget(
      color: Color(0xFF203354),
      width: 0.85 * MediaQuery.of(context).size.width,
      height: 0.67 * MediaQuery.of(context).size.height,
      isCornerRounded: true,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.009),
      child: TicketData(data: data, event: event),

    );

  }
}

class TicketData extends StatelessWidget {
  var data;
  var event;
  TicketData({

    Key? key, required this.data, required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [

            Expanded(
              child: Text(
                "",
                style: TextStyle(fontSize: 20.0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
            Image(image: AssetImage('./Images/anokha_2023_white_small.png'),
                width: 120.0),
          ],
        ),

        Container(
          width: double.infinity,
          child: Text(
            "Entry Ticket",
            style: TextStyle(fontSize: 23.0,
                color: Color(0xFFBEB7AA),
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.left,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.03, vertical: MediaQuery.of(context).size.height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Name", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: data.fullName.split(' ').map<Widget>((word) {
                          return Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Text(
                              word,
                              style: TextStyle(fontSize: 15.0, color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Program Name", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["eventName"], style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Type", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["type"] == 0 ? "Event" : "Workshop", style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    ),

                  ],
                ),
              ),
              Expanded(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Date", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["date"], style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Time", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["eventTime"], style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Venue", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["venue"], style: TextStyle(fontSize: 15.0,color: Colors.white),),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),

        QrImage(
          foregroundColor : Colors.white,
          data: "{json data to be passed}",
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.height * 0.2,
          gapless: false,

          embeddedImageStyle: QrEmbeddedImageStyle(
            size: Size(MediaQuery.of(context).size.height * 0.05, MediaQuery.of(context).size.height * 0.05),
          ),
          errorStateBuilder: (cxt, err) {
            return Container(
              child: Center(
                child: Text(
                  "Please Conatct User App Developers",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        )


      ],
    );
  }
}