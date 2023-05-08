import 'package:anokha_home/event_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//Cards for trending events

class AnokhaCards extends StatefulWidget {
  var data;
  var token;
  AnokhaCards({Key? key, required List<dynamic> this.data, this.token})
      : super(key: key);

  @override
  State<AnokhaCards> createState() => _AnokhaCardsState();
}

class _AnokhaCardsState extends State<AnokhaCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventInfo(
                                event_map: widget.data[0],
                                data: widget.token,
                              )));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.data[0].url),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFFEFECF0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.90,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          widget.data[0].name,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventInfo(
                                event_map: widget.data[1],
                                data: widget.token,
                              )));
                },
                child: Column(
                  children: [


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.data[1].url),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFFEFECF0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.90,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          widget.data[1].name,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventInfo(
                                event_map: widget.data[2],
                                data: widget.token,
                              )));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.data[2].url),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFFEFECF0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.90,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          widget.data[2].name,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventInfo(
                                event_map: widget.data[3],
                                data: widget.token,
                              )));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.data[3].url),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFFEFECF0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.90,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          widget.data[3].name,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventInfo(
                                event_map: widget.data[4],
                                data: widget.token,
                              )));
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.data[4].url),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFFEFECF0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.width * 0.90,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          widget.data[4].name,
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.dmSans(textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
