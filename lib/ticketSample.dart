import 'dart:convert';

import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'Loading_Screens/events_loading.dart';
import 'homePage.dart';
import 'ticketSample.dart';



//Shows the upcoming event of a person in the form of a ticket.


class MyTicketView extends StatelessWidget {
  var data;
  var event;
  MyTicketView({Key? key, required this.data, required this.event}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return TicketWidget(

              color: Colors.white,
              width: 0.85 * MediaQuery.of(context).size.width,
              height: 0.633 * MediaQuery.of(context).size.height,
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
            Image(image: AssetImage('./Images/anokha_2023_black_small.png'),
                width: 120.0),
          ],
        ),

        Container(
          width: double.infinity,
          child: Text(
            "Entry Ticket",
            style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 23.0,
                color: Color(0xFF002845),
                fontWeight: FontWeight.w700)),
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
                      child: Text("Name", style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA))),),
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
                              style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0, color: Colors.black),)
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Program Name", style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA))),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["eventName"],
                        maxLines: 2,
                        style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0,color: Colors.black)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Type", style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA))),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["eventOrWorkshop"] == 0 ? "Event" : "Workshop", style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0,color: Colors.black)),),
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
                      child: Text("Date", style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA))),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["date"], style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0,color: Colors.black)),),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Time", style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA))),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["eventTime"], style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0,color: Colors.black)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.007),
                      child: Text("Venue", style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA))),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      child: Text(event[0]["venue"], style: GoogleFonts.dmSans(textStyle: TextStyle(fontSize: 15.0,color: Colors.black)),),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),

        QrImage(
          foregroundColor : Color(0xff002845),
          data: (event[0]["eventId"]) == 111 ? "${data.userEmail}" : "${data.userEmail}/${event[0]["eventId"]}",

          version: QrVersions.auto,
          size: MediaQuery.of(context).size.height * 0.18,
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