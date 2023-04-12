import 'dart:convert';

import 'package:anokha_home/serverUrl.dart';
import 'package:anokha_home/ticketSample.dart';
import 'package:anokha_home/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'Loading_Screens/events_loading.dart';

final __url = serverUrl().url;
const itemSize = 280.0;

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          selected ? -100.0 : 0.0,
          0.0,
        ),
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text('Card Content'),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final String avatarLink;
  var data;
  MainPage({Key? key, required this.avatarLink, required this.data})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static bool countdownEnded = false;
  final pageController = PageController();
  String assetName = 'Images/campus.svg';

  Future getEntryCard() async {
    String url = __url + "userApp/events/nextEvent";
    final response = await http.get(Uri.parse(url),
        headers: {'authorization': 'Bearer ${widget.data.SECRET_TOKEN}'});
    return json.decode(response.body);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: TextStyle(color: Color(0xFF002845))),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes', style: TextStyle(color: Color(0xFF002845))),
              ),
            ],
          ),
        )) ??
        false;
  }

  final scrollController = ScrollController();

  void onListen() {
    if (scrollController.position.atEdge &&
        scrollController.position.pixels == 0) {
      pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Color(0xFF002845),
          body: Scaffold(
            backgroundColor: Color(0xFF002845),
            body: _MainPageState.countdownEnded
                ? FutureBuilder(
                    future: getEntryCard(),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        print("error");
                      }
                      if (snapshot.hasData) {
                        return Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: AnimatedOpacity(
                                duration: Duration(seconds: 5),
                                curve: Curves.easeInOut,
                                opacity: countdownEnded ? 1.0 : 0.0,
                                child: SafeArea(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'Images/anokha_circle.png'),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                            ),
                                            ClipOval(
                                              child: Image(
                                                image: NetworkImage(
                                                    widget.avatarLink),
                                                fit: BoxFit.cover,
                                                width:
                                                    40.0, // set the width and height to make the image circular
                                                height: 40.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Up Next For You",
                                              style: TextStyle(color: Color(0xFFBEB7A4),
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017),
                                          child: MyTicketView(
                                              data: widget.data,
                                              event: snapshot.data),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        );
                      } else {
                        return Events_Loading_screen();
                      }
                    })
                : PageView(
                    controller: pageController,
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.17),
                              child: Image.asset('Images/anokha_text_comp.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.8),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.05),
                              child: Transform.scale(
                                scale: 2.0,
                                child: SvgPicture.asset(
                                  'Images/clg.svg',
                                  semanticsLabel: 'My SVG Image',
                                  color: Colors.white,
                                  height:
                                      MediaQuery.of(context).size.height * 0.33,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              child: Text("Begins In",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22.0)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    child: countdownEnded
                                        ? Center(
                                            child: MyTicketView(
                                            data: widget.data,
                                            event: null,
                                          ))
                                        : CountdownPage(
                                            onCountdownComplete: () {
                                              print(widget.data);
                                              setState(() {
                                                _MainPageState.countdownEnded = true;
                                              });
                                            },
                                          ),
                                  ),
                                  Spacer()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Container(
                              constraints: BoxConstraints.expand(
                                  height: MediaQuery.of(context).size.height *
                                      0.13),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index < 15) {
                                  final itemPositionOffset =
                                      index * itemSize * 0.9;
                                  final difference = scrollController.offset -
                                      itemPositionOffset;
                                  final percent =
                                      1.2 - difference / itemSize * 0.7;
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
                                        child: CardWidget(),
                                      ),
                                    ),
                                  );
                                } else {
                                  return null;
                                }
                              },
                              childCount: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
          ),
        ));
  }
}
