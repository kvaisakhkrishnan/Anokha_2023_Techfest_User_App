import 'dart:collection';

import 'package:anokha_home/event_info.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetStarrs extends StatefulWidget {
  const GetStarrs({Key? key}) : super(key: key);

  @override
  State<GetStarrs> createState() => _GetStarrsState();
}

class _GetStarrsState extends State<GetStarrs> {
  String url = "http://52.66.236.118:3060/userApp/getStarredEvents";

  Future<Map<String, dynamic>> getData() async {
    var token =
        "v4.public.eyJ1c2VyRW1haWwiOiJjYi5lbi51NGNzZTIwMDEwQGNiLnN0dWRlbnRzLmFtcml0YS5lZHUiLCJmdWxsTmFtZSI6IkZJUlNUTkFNRTAgTEFTVE5BTUUwIiwiY29sbGVnZU5hbWUiOiJBYXphZCBDb2xsZWdlIG9mIEVkdWNhdGlvbiAoSWQ6IEMtMzkyMzApIiwiZGlzdHJpY3QiOiJQcmFrYXNhbSIsImNvdW50cnkiOiJJTkRJQSIsInJvbGUiOiJVU0VSIiwic2VjcmV0X2tleSI6IkUpSEBNY1FmVGpXblpyNHU3eCFBJUQqRy1KYU5kUmdVa1hwMnM1djh5L0I_RShIK01iUGVTaFZtWXEzdDZ3OXokQyZGKUpATmNSZlRqV25acjR1N3ghQSVEKkctS2FQZFNnVmtYcDJzNXY4eS9CP0UoSCtNYlFlVGhXbVpxM3Q2dzl6JEMmRilKQE5jUmZValhuMnI1dTd4IUElRCpHLUthUGRTZ1ZrWXAzczZ2OXkkQj9FKEgrTWJRZVRoV21acTR0N3cheiVDKkYpSkBOY1JmVWpYbjJyNXU4eC9BP0QoRytLYVBkU2dWa1lwM3M2djl5JEImRSlIQE1jUWVUaFdtWnE0dDd3IXolQypGLUphTmRSZ1VqWG4ycjV1OHgvQT9EKEcrS2JQZVNoVm1ZcDNzNnY5eSRCJkUpSEBNY1FmVGpXblpyNHQ3dyF6JUMqRi1KYU5kUmdVa1hwMnM1djh4L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXokQiZFKUhATWNRZlRqV25acjR1N3ghQSVEKkYtSmFOZFJnVWtYcDJzNXY4eS9CP0UoSCtLYlBlU2hWbVlxM3Q2dzl6JEMmRilKQE5jUWZUalduWnI0dTd4IUElRCpHLUthUGRTZ1VrWHAyczV2OHkvQj9FKEgrTWJRZVRoV21ZcTN0Nnc5eiRDJEImRShIK01iUWVUaFdtWnE0dDd3IXolQypGLUpATmNSZlVqWG4ycjV1OHgvQT9EKEcrS2JQZFNnVmtZcDNzNnY5eSRCJkUpSEBNY1FmVGhXbVpxNHQ3dyF6JUMqRi1KYU5kUmdVa1huMnI1dTh4L0E_RChHK0tiUGVTaFZtWXEzczZ2OXkkQiZFKUhATWNRZlRqV25acjR1N3cheiVDKkYtSmFOZFJnVWtYcDJzNXY4eS9BP0QoRytLYlBlU2hWbVlxM3Q2dzl6JEMmRSlIQE1jUWZUalduWnI0dTd4IUElRCpHLUphTmRSZ1VrWHAyczV2OHkvQj9FKEgrTWJQZVNoVm1ZcTN0Nnc5eiRDJkYpSkBOY1JmVGpXblpyNHU3eCFBJUQqRy1LYVBkU2dWa1lwMnM1djh5L0I_RShIK01iUWVUaFdtWnE0dDZ3OXokQyZGKUpATmNSZlVqWG4ycjV1OHghQSVEKkctS2FQZFNnVmtZcDNzNnY5eSRCP0UoSCtNYlFlVGhXbVpxNHQ3dyF6JUMqRilKQE5jUmZValhuMnI1dTh4L0E_RChHK0thUGRTZ1ZrWXAzczZ2OXkkQiZFKUhATWNRZVRoV21acTR0N3cheiVDKkYtSmFOZFJnVWpYbjJyNXU4eC9BP0QoRytLYlBlU2hWbVlwM3M2djl2OHkvQj9FKEcrS2JQZVNoVm1ZcTN0Nnc5eiRDJkYpSkBNY1FmVGpXblpyNHU3eCFBJUQqRy1LYVBkUmdVa1hwMnM1djh5L0I_RShIK01iUWVUaFZtWXEzdDZ3OXokQyZGKUpATmNSZlVqWG5acjR1N3ghQSVEKkctS2FQZFNnVmtZcDNzNXY4eS9CP0UoSCtNYlFlVGhXbVpxNHQ3dzl6JEMmRilKQE5jUmZValhuMnI1dTh4L0ElRCpHLUthUGRTZ1ZrWXAzczZ2OXkkQiZFKEgrTWJRZVRoV21acTR0N3cheiVDKkYtSkBOY1JmVWpYbjJyNXU4eC9BP0QoRytLYlBkU2dWa1lwM3M2djl5JEImRSlIQE1jUWZUaFdtWnE0dDd3IXolQypGLUphTmRSZ1VrWG4ycjV1OHgvQT9EKEcrS2JQZVNoVm1ZcTNzNnY5eSRCJkUpSEBNY1FmVGpXblpyNHU3dyF6JUMqRi1KYU5kUmdVa1hwMnM1djh5L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXokQyZFKUhATWNRZlRqV25acjR1N3ghQSVEKkctS2FOZFJnVWtYcDJzNXY4eS9CP0UoSCtNYlFlU2hWbVlxM3Q2dzl6JEMmRilKQE5jUmZValduWnI0dTd4IUElRCpHLUthUGRTZ1ZrWXAyczJyNXU4eC9BP0QoRy1LYVBkU2dWa1lwM3M2djl5JEImRSlIQE1iUWVUaFdtWnE0dDd3IXolQypGLUphTmRSZlVqWG4ycjV1OHgvQT9EKEcrS2JQZVNoVmtZcDNzNnY5eSRCJkUpSEBNY1FmVGpXblpxNHQ3dyF6JUMqRi1KYU5kUmdVa1hwMnM1dTh4L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXkkQiZFKUhATWNRZlRqV25acjR1N3ghQSVDKkYtSmFOZFJnVWtYcDJzNXY4eS9CP0UoRytLYlBlU2hWbVlxM3Q2dzl6JEMmRilKQE1jUWZUalduWnI0dTd4IUElRCpHLUthUGRSZ1VrWHAyczV2OHkvQj9FKEgrTWJRZVRoVm1ZcTN0Nnc5eiRDJkYpSkBOY1JmVWpYblpyNHU3eCFBJUQqRy1LYVBkU2dWa1lwM3M1djh5L0I_RShIK01iUWVUaFdtWnE0dDd3OXokQyZGKUpATmNSZlVqWG4ycjV1OHgvQSVEKkctS2FQZFNnVmtZcDNzNnY5eSRCJkUoSCtNYlFlVGhXbVpxNHQ3dyF6JUMqRi1KQE5jUmZValhuMnI1dTh4L0E_RChHK0tiUGRTZ1ZrWXAzczZ2OXkkQiZFKUhATWNRZlRoV21acTR0N3cheiVDKkYtSmFOZFJnVWtYaXdoamRqd2lkanFzcW93YmR4aGpXblpyNHU3eCFBJUQqRi1KYU5kUmdVa1hwMnM1djh5L0I_RShIK0tiUGVTaFZtWXEzdDZ3OXokQyZGKUpATmNRZlRqV25acjR1N3ghQSVEKkctS2FQZFNnVWtYcDJzNXY4eS9CP0UoSCtNYlFlVGhXbVlxM3Q2dzl6JEMmRilKQE5jUmZValhuMnI1dTd4IUElRCpHLUthUGRTZ1ZrWXAzczZ2OXkvQj9FKEgrTWJRZVRoV21acTR0N3cheiVDJkYpSkBOY1JmVWpYbjJyNXU4eC9BP0QoRy1LYVBkU2dWa1lwM3M2djl5JEImRSlIQE1iUWVUaFdtWnE0dDd3IXolQypGLUphTmRSZlVqWG4ycjV1OHgvQT9EKEcrS2JQZVNoVmtZcDNzNnY5eSRCJkUpSEBNY1FmVGpXblpxNHQ3dyF6JUMqRi1KYU5kUmdVa1hwMnM1dTh4L0E_RChHK0tiUGVTaFZtWXEzdDZ3OXkkQiZFKUhATWNRZlRqV25acjR1N3ghQSVDKkYtSmFOZFJnVWtYcDJzNXY4dyIsImlhdCI6IjIwMjMtMDQtMDhUMDk6MjQ6MjMuMjA3WiIsImV4cCI6IjIwMjMtMDQtMDhUMTA6MjQ6MjMuMjA3WiJ9EPvKHdoGlp6892xZeidfw3-lrRE0GPmLeq39Se_AMaR4-VqQz5Fgs1Bm8UUB3ii4GKWX85gXUBN7ZNre4lEhBg";
    final response = await http
        .get(Uri.parse(url), headers: {'authorization': 'Bearer $token'});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
          future: getData(),
          builder: (context, ss) {
            if (ss.hasError) {
              print("error");
            }
            if (ss.hasData) {
              return Wheel(starr_map: ss.data);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

class Wheel extends StatefulWidget {
  Map<String, dynamic>? starr_map;

  Wheel({Key? key, required this.starr_map}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  final _scrollController = FixedExtentScrollController();
  late BuildContext ctx1;
  @override
  Widget build(BuildContext context) {
    ctx1 = context;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Starred Events",
          style: GoogleFonts.dmSans(
              color: HexColor("#002845"), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: (widget.starr_map?.length == 0)
          ? Center(child: Text("You have not starred any events"))
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: InkWell(
                    child: New_Widget(index: index, starrs: widget.starr_map),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventInfo(
                                  event_map: widget
                                      .starr_map?[index])));
                    },
                  ),
                );
              }),
              itemCount: widget.starr_map?["nonstarredEvents"].length,
              /*child: ListWheelScrollView.useDelegate(
                physics: FixedExtentScrollPhysics(),
                itemExtent: MediaQuery.of(context).size.height * 0.26,
                perspective: 0.001,
                childDelegate: ListWheelChildBuilderDelegate(
                    childCount: widget.starr_map?["nonstarredEvents"].length,
                    builder: (context, index) {
                      return New_Widget(index: index, starrs: widget.starr_map);
                    }),
              ),*/
            ),
    );
  }
}

class New_Widget extends StatefulWidget {
  int? index;
  Map<String, dynamic>? starrs;
  New_Widget({Key? key, required this.index, this.starrs}) : super(key: key);

  @override
  State<New_Widget> createState() => _New_WidgetState();
}

class _New_WidgetState extends State<New_Widget> {
  BuildContext? ctx;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(30),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor("#193d57"), HexColor("#002845")]),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              height: 150,
              width: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          widget.starrs!["nonstarredEvents"][widget.index]
                              ["name"],
                          maxLines: 4,
                          style: GoogleFonts.dmSans(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Image(
                          height: 100,
                          width: 100,
                          image:
                              AssetImage("images/anokha_2023_white_small.png"))
                    ],
                  ),
                  Text(
                    "${widget.starrs!["nonstarredEvents"][widget.index]["department"]} | ${widget.starrs!["nonstarredEvents"][widget.index]["type"]}",
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.bold,
                        color: HexColor("#FF7F11"),
                        fontSize: 25),
                  )
                ],
              )),
        ));
  }
}
