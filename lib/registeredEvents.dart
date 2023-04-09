import 'dart:convert';

import 'package:anokha_home/registeredEventsCard.dart';
import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  var registeredEvents = [];
  bool _isLoading = true;

  void onListen() {
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onListen);
    super.initState();
    getRegistered().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }

  void onSearch() {
    // Perform search using the searchController.text value
    print('Performing search for ${searchController.text}');
  }

  Future<void> getRegistered() async {
    String url = __url + "userApp/events/myRegistered";
    final response = await http.get(Uri.parse(url),
        headers: {'authorization': 'Bearer ${widget.data.SECRET_TOKEN}'});
    print(json.decode(response.body));
    registeredEvents = json.decode(response.body);

    print(registeredEvents);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 3, bottom: 3),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Card',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                iconSize: 30,
                onPressed: onSearch,
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
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
    );
  }
}