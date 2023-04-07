import 'package:anokha_home/serverUrl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Loading_Screens/events_loading.dart';

final __url = serverUrl().url;

class GetCrew extends StatefulWidget {
  final data;
  GetCrew({Key? key, required this.data}) : super(key: key);

  @override
  State<GetCrew> createState() => _GetCrewState();
}

class _GetCrewState extends State<GetCrew> {
  late Future<List?> _crewDataFuture;

  @override
  void initState() {
    super.initState();
    _crewDataFuture = CrewDataManager().getCrewData(token: widget.data.SECRET_TOKEN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List?>(
            future: _crewDataFuture,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print("error");
              }
              if (snapshot.hasData) {
                return CrewMembers(list: snapshot.data);
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
    final List<String> items = List.generate(crew_list.length, (index) => crew_list[index]["role"] ?? "");
    final List<int> a = List.generate(crew_list.length, (index) => index);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {},
                  splashRadius: 20,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: HexColor("#FFFFFC"),
                  )),

            ),
            body: Column(
              children: [
                Container(
                  height: 120,
                  child: GridView.count(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      childAspectRatio: 2 / 6,
                      children: items
                          .map((item) => Padding(
                        padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                            primary:
                            (items.indexOf(item) + 1 == selected_index)
                                ? HexColor("#FFFFFC")
                                : HexColor("#002845"),
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            setState(() {
                              numbers = crew_list[items.indexOf(item)]
                              ["crews"]
                                  .length;
                              selected_index = items.indexOf(item) + 1;
                            });
                          },
                          child: Text(
                            item,
                            maxLines: 2,
                            style: GoogleFonts.dmSans(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: (items.indexOf(item) + 1 ==
                                    selected_index)
                                    ? HexColor("#002845")
                                    : HexColor("#FFFFFC")),
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
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: (selected_index == 1) ? (crew_list[0]["crews"]?.length ?? 0) : numbers,
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
                                          padding:
                                          EdgeInsets.only(top: circleRadius),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                side:
                                                BorderSide(color: Colors.white),
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
                                                      crew_list[selected_index - 1]
                                                      ["crews"][index]["name"],
                                                      maxLines: 5,
                                                      style: GoogleFonts.dmSans(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        crew_list[selected_index -
                                                            1]["crews"][index]
                                                        ["department"],
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.orange),
                                                      ),
                                                    )
                                                  ]),
                                                ),
                                              ),
                                            ),
                                            color: HexColor("#FFFFFC"),
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
                                                    builder: (_) => ImageDialog());
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
          )),
    );
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


class CrewDataManager {
  static final CrewDataManager _singleton = CrewDataManager._internal();

  factory CrewDataManager() {
    return _singleton;
  }

  CrewDataManager._internal();

  List? _crewData;

  Future<List?> getCrewData({required String token}) async {
    if (_crewData == null) {
      await _fetchCrewData(token: token);
    }
    return _crewData;
  }

  Future<void> _fetchCrewData({required String token}) async {
    String url = __url + "userApp/getCrew";
    final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'}
    );
    _crewData = json.decode(response.body);
  }

  void clearData() {
    _crewData = null;
  }
}
