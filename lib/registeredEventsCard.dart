import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';



class RegisteredEventCard extends StatefulWidget {
  final Map<String, dynamic> event;
var data;
  RegisteredEventCard({Key? key, required this.event, required this.data}) : super(key: key);
  bool selected = false;
  bool takeThere = false;

  @override
  State<RegisteredEventCard> createState() =>
      _RegisteredEventCardState(event: event);
}


class _RegisteredEventCardState extends State<RegisteredEventCard> {
  final Map<String, dynamic> event;

  _RegisteredEventCardState({required this.event});



  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(
        0.0,
        widget.selected ? -100.0 : 0.0,
        0.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.selected = !widget.selected;
            });
          },
          onLongPress: () {
            if (widget.selected == true) {
              widget.takeThere = true;
            }
          },
          child: Container(
            constraints: BoxConstraints.expand(height: 280.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [BoxShadow(color: Color(0xff002845), blurRadius: 100, spreadRadius: 10)]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                        child: Text("Entry Card",
                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.w500
                          )),
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                        child: Image(image: AssetImage('./Images/logo.png')),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          '${event['eventOrWorkshop'] == 0 ? "Event" : "Workshop"} | ${event['technical'] ==0 ? "Non Technical" : "Technical"}',
                          style:GoogleFonts.dmSans(textStyle:  TextStyle(color: Color(0xFFFF3F11))),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    event['eventName'],
                    style: GoogleFonts.dmSans(textStyle: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    'Venue: ${event['venue']}',
                    style: GoogleFonts.dmSans(textStyle: TextStyle(
                      fontSize: 15.0,

                    )),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Valid on\n${event['date']}'  ?? 'Unknown Event',
                            style: GoogleFonts.dmSans(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Time\n${event['eventTime']}'  ?? 'Unknown Event',
                            style: GoogleFonts.dmSans(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: QrImage(
                            foregroundColor : Color(0xffbeb7a4),
                            data: "${widget.data.userEmail}/${widget.event["eventId"]}",
                            version: QrVersions.auto,
                            size: MediaQuery.of(context).size.height * 0.19,
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
