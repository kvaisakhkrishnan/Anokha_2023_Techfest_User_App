import 'package:flutter/foundation.dart';
import 'package:anokha_home/homeBody.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';

class GetCrew extends StatefulWidget {
  const GetCrew({Key? key}) : super(key: key);

  @override
  State<GetCrew> createState() => _GetCrewState();
}

class _GetCrewState extends State<GetCrew> {
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

  String url = "https://anokha.amrita.edu/api/userApp/getCrew";

  Future<List> getData() async {
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List>(
            future: getData(),
            builder: (context, ss) {
              if (ss.hasError) {
                print("error");
              }
              if (ss.hasData) {
                if(listEquals(ss.data, []))
                  {
                    return Scaffold(
                      backgroundColor: Color(0xff002845),
                      body: Center(
                          child: Text(
                            "Page under development",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            maxLines: 3,
                          )),
                    );
                  }
                else{
                  return CrewMembers(list: ss.data);
                }

              } else {
                return Events_Loading_screen();
              }
            }));
  }
}

class CrewMembers extends StatefulWidget {
  List? list;
  CrewMembers({Key? key, required this.list}) : super(key: key);

  List? getList() {
    return this.list;
  }

  @override
  State<CrewMembers> createState() => _CrewMembersState();
}

class _CrewMembersState extends State<CrewMembers> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  late List crew_list;

  @override
  void initState() {
    super.initState();
    crew_list = widget.list!;
  }

  final double circleRadius = 30.0;

  Color selected_color = HexColor("#002845");
  int selected_index = 1;
  int numbers = 1;
  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(
        crew_list.length, (index) => crew_list[index]["teamName"]);
    final List<int> a = List.generate(crew_list.length, (index) => index);

    return (widget.list?.length == 0)
        ? Scaffold(
            body: Center(child: Text("No Crew Members Yet")),
          )
        : Container(
            child: Scaffold(
            backgroundColor: Color(0xFF002845),
            appBar: AppBar(
              backgroundColor: Color(0xFF002845),
              elevation: 0,
              title: Text("Crew Members",
                  style: GoogleFonts.dmSans(color: Colors.white)),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      childAspectRatio: 2 / 6,
                      children: items
                          .map((item) => Padding(
                                padding: EdgeInsets.fromLTRB(8, 15, 8, 2),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    side: (items.indexOf(item) + 1 ==
                                            selected_index)
                                        ? BorderSide(color: Colors.white)
                                        : BorderSide(
                                            color: Colors.white, width: 2),
                                    primary: (items.indexOf(item) + 1 ==
                                            selected_index)
                                        ? Colors.white
                                        : HexColor("#002845"),
                                    shape: StadiumBorder(),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      numbers = crew_list[items.indexOf(item)]
                                              ["member"]
                                          .length;
                                      selected_index = items.indexOf(item) + 1;
                                    });
                                  },
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      item,
                                      style: GoogleFonts.dmSans(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: (items.indexOf(item) + 1 ==
                                                  selected_index)
                                              ? HexColor("#002845")
                                              : Colors.white),
                                    ),
                                  ),
                                ),
                              ))
                          .toList()),
                ),
                Expanded(
                  flex: 4,
                  child: AnimationLimiter(
                    child: Container(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: (selected_index == 1)
                              ? crew_list[0]["member"].length
                              : numbers,
                          padding: EdgeInsets.only(
                              left: 20, right: 10, top: 10, bottom: 10),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              columnCount: 2,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Stack(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: circleRadius),
                                          child: Card(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Column(children: [
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Text(
                                                      crew_list[selected_index -
                                                              1]["member"]
                                                          [index]["name"],
                                                      maxLines: 5,
                                                      style: GoogleFonts.dmSans(
                                                          color:
                                                              Color(0xFF002845),
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: Text(
                                                        crew_list[selected_index -
                                                                    1]["member"]
                                                                [index]
                                                            ["departmentname"],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Colors.orange),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                            ),
                                            elevation: 10,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4 /
                                                    11.0),
                                            child: InkWell(
                                              onTap: () async {
                                                await showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        ImageDialog());
                                              },
                                              child: CircleAvatar(
                                                radius: circleRadius,
                                                backgroundColor:
                                                    HexColor("#002845"),
                                                backgroundImage: NetworkImage(
                                                  "https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg",
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ));
    ;
  }
}

class ImageDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://png.pngtree.com/png-vector/20191101/ourmid/pngtree-cartoon-color-simple-male-avatar-png-image_1934459.jpg"),
                fit: BoxFit.fill)),
      ),
    );
  }
}
