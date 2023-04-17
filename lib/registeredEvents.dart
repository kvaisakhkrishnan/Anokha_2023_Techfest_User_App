import 'dart:convert';

import 'package:anokha_home/SessionExpired/sessionExpired.dart';
import 'package:anokha_home/registeredEventsCard.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'Loading_Screens/events_loading.dart';
import 'homePage.dart';

const itemSize = 280.0;

final __url = serverUrl().url;

class RegisteredEvents extends StatefulWidget {
  var data;

  RegisteredEvents({Key? key, required this.data}) : super(key: key);

  @override
  State<RegisteredEvents> createState() => _RegisteredEventsState();
}

class _RegisteredEventsState extends State<RegisteredEvents> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No',style: TextStyle(color: Color(0xFF002845))),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes',style: TextStyle(color: Color(0xFF002845))),
          ),
        ],
      ),
    )) ??
        false;
  }
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  var registeredEvents = [];

  bool _isLoading = false;
  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onListen);
    super.initState();
    setState(() {
      _isLoading = true;
    });
    getRegistered().then((_) {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }



  Future<void> getRegistered() async {
    String url = __url + "userApp/events/myRegistered";
    final response = await http.get(Uri.parse(url),
        headers: {'authorization': 'Bearer ${widget.data.SECRET_TOKEN}'});
    _isLoading = false;
    if(response.statusCode == 401)
      {
        registeredEvents = ["SESSIONEXPIRATIONERROR"];
      }
    else {
      registeredEvents = json.decode(response.body);
    }


  }

  @override
  Widget build(BuildContext context) {
    return  registeredEvents.length == 0  && _isLoading == false? Scaffold(
      backgroundColor: Color(0xff002845),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [Text(
              "404",
              style: GoogleFonts.dmSans(textStyle: TextStyle(color: Color(0xffbeb7a4), fontSize: MediaQuery.of(context).size.width * 0.2)),
              maxLines: 3,
            ),

              Text("No Registered Events",
                style: GoogleFonts.dmSans(
                    textStyle: TextStyle(color:Colors.white, fontSize: 18 )
                ),)]),
      ),
    ) : (listEquals(registeredEvents,["SESSIONEXPIRATIONERROR"]) ? SessionExpired() : WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Color(0xff002845),
          elevation: 0,
          toolbarHeight: 0,
        ),
        backgroundColor: Color(0xff002845),
        body: _isLoading
            ? Center(child: Events_Loading_screen())
            : Padding(
          padding: const EdgeInsets.all(0.0),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * 0.13),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index < registeredEvents.length) {
                      final itemPositionOffset = index * itemSize * 0.7;
                      final difference =
                          scrollController.offset - itemPositionOffset;
                      final percent = 1.2 - difference / itemSize * 0.7;
                      double opacity = percent;
                      double scale = percent;
                      if (opacity >= 1.0) opacity = 1.0;
                      if (opacity < 0.0) opacity = 0.0;
                      if (percent >= 1.0) scale = 1.0;
                      return Align(
                        heightFactor: 0.7,
                        child: Opacity(
                          opacity: opacity,
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..scale(scale, 1.0),
                            child: RegisteredEventCard(
                              event: registeredEvents[index],
                              data: widget.data
                            ),
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                  childCount: registeredEvents.length,
                ),
              ),
            ],
          ),
        ),
      ),
    )

    );
  }





  }