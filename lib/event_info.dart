// import 'dart:collection';
//
// import 'package:anokha_app/thememode.dart';
// import 'package:faded_widget/faded_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
//
//
//
// class EventInfo extends StatefulWidget {
//   bool txt_visible = false;
//
//   EventInfo({Key? key}) : super(key: key) {
//     txt_visible = false;
//   }
//
//   @override
//   State<EventInfo> createState() => _EventInfoState();
// }
//
// class _EventInfoState extends State<EventInfo> {
//   ScrollController _controller = ScrollController();
//   bool liked = false;
//   var a = new DarkTheme();
//
//   Color bg = HexColor("#000000");
//
//   void _onScrollEvent() {}
//
//   @override
//   void initState() {
//     _controller.addListener(_onScrollEvent);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.removeListener(_onScrollEvent);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//             backgroundColor: HexColor("#002845"),
//             body: Stack(
//               children: [
//                 Container(
//                     height: 300.0,
//                     width: MediaQuery.of(context).size.width * 1,
//                     child: Image(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(
//                             "https://www.atlasandboots.com/wp-content/uploads/2019/05/ama-dablam2-most-beautiful-mountains-in-the-world.jpg"))),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(0, 0, 0, 90),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(color: HexColor("#FFFFFC")),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(50),
//                           ),
//                           color: HexColor("#FFFFFC")),
//                       height: 500,
//                       width: 460,
//                       child: NotificationListener(
//                           /*child: Scrollbar(
//                           isAlwaysShown: false,
//                           controller: _controller,
//                           showTrackOnHover: true,*/
//                           child: SingleChildScrollView(
//                             controller: _controller,
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           0, 10, 10, 0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Visibility(
//                                             visible: false,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       10, 0, 0, 0),
//                                               child: Icon(Icons.message),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 0, 0, 10, 0),
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 Icons.star,
//                                                 size: 30,
//                                                 color: liked
//                                                     ? Colors.yellow.shade700
//                                                     : Colors.black,
//                                               ),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   liked = !liked;
//                                                 });
//                                               },
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.fromLTRB(
//                                             20.0, 0.0, 40.0, 10.0),
//                                         child: Text(
//                                           "Machine Learning\nWorkshop",
//                                           style: TextStyle(
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 50.0,
//                                       ),
//                                       Text(
//                                         "₹200",
//                                         style: TextStyle(
//                                             backgroundColor: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 30.0),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Container(
//                                         width: 150,
//                                         decoration: BoxDecoration(
//                                             gradient: LinearGradient(colors: [
//                                               HexColor("#FF7F11"),
//                                               HexColor("#FF3F00")
//                                             ]),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Row(
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.fromLTRB(
//                                                   10, 10, 0, 10),
//                                               child: Row(children: [
//                                                 Icon(
//                                                   Icons.location_on,
//                                                   size: 30,
//                                                   color: Colors.white,
//                                                 ),
//                                                 SizedBox(
//                                                   width: 7,
//                                                 ),
//                                                 Text(
//                                                   "Location",
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 )
//                                               ]),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 15.0,
//                                       ),
//                                       Text(
//                                         "AB3 Block A203",
//                                         style: TextStyle(
//                                             color: HexColor("#A0A0A0"),
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20),
//                                       )
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       Material(
//                                         color: HexColor("#002845"),
//                                         elevation: 10,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(20)),
//                                         child: Container(
//                                           height: 120,
//                                           width: 120,
//                                           child: Padding(
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 15, 10, 10, 10),
//                                             child: Column(
//                                               children: [
//                                                 Icon(
//                                                   Icons.person,
//                                                   size: 30,
//                                                   color: Colors.white,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 Text(
//                                                   "6\nAvailable Seats",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 15),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Material(
//                                         color: HexColor("#002845"),
//                                         elevation: 10,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(20))),
//                                         child: Container(
//                                           height: 120,
//                                           width: 120,
//                                           child: Padding(
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 15, 10, 10, 10),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Icon(
//                                                   Icons.timer,
//                                                   size: 30,
//                                                   color: Colors.white,
//                                                 ),
//                                                 SizedBox(
//                                                   height: 10,
//                                                 ),
//                                                 Text(
//                                                   "March 31",
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 15),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                     child: Text(
//                                       "Simply put, a paragraph is a collection of sentences all related to a central topic, idea, or theme. Paragraphs act as structural tools for writers to organize their thoughts into an ideal progression, and they also help readers process those thoughts effortlessly. Imagine how much harder reading and writing would be if everything was just one long block of text.There’s a lot of flexibility when it comes to writing paragraphs, but if there’s one steadfast rule, it’s this: Paragraphs should relate to one main topic or point. The paragraph itself often contains multiple points spanning several sentences, but they should all revolve around one core theme. Just as sentences build upon each other to communicate the paragraph’s core theme, paragraphs work together to communicate the core theme of the writing as a whole. ",
//                                       textDirection: TextDirection.ltr,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                           onNotification: (notificationInfo) {
//                             if (notificationInfo is ScrollStartNotification) {
//                               setState(() {
//                                 widget.txt_visible = true;
//                                 print("${widget.txt_visible}");
//                               });
//
//                               /// your code
//                             }
//                             return true;
//                           }),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 720, 0, 0),
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: HexColor("#002845"),
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(20),
//                                 bottomRight: Radius.circular(20))),
//                         child: Center(
//                           child: Visibility(
//                             visible: widget.txt_visible,
//                             child: SizedBox(
//                               height: 50,
//                               width: 200,
//                               child: Container(
//                                 decoration: ShapeDecoration(
//                                     shape: StadiumBorder(),
//                                     color: Colors.white),
//                                 child: TextButton(
//                                     onPressed: () {},
//                                     child: Center(
//                                         child: Text("Register",
//                                             style: TextStyle(
//                                                 color: HexColor("#002845"),
//                                                 fontSize: 30)))),
//                               ),
//                             ),
//                           ),
//                         )))
//               ],
//             )));
//   }
// }
