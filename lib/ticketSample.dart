import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MyTicketView();

  }
}

class MyTicketView extends StatelessWidget {
  const MyTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TicketWidget(
          color: Color(0xFF203354),
          width: 0.85 * MediaQuery.of(context).size.width,
          height: 0.60 * MediaQuery.of(context).size.height,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: TicketData(),
        );

  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
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
              Image(image: AssetImage('./Images/anokha_2023_white_small.png'),
                  width: 120.0),
            ],
          ),

        Container(
          width: double.infinity,
          child: Text(
            "Entry Ticket",
            style: TextStyle(fontSize: 23.0,
            color: Color(0xFFBEB7AA),
            fontWeight: FontWeight.w700),
            textAlign: TextAlign.left,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Name", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Vaisakhkrishnan K", style: TextStyle(fontSize: 15.0, color: Colors.white),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Program Name", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Treasure Hunt", style: TextStyle(fontSize: 15.0,color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Type", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("Workshop", style: TextStyle(fontSize: 15.0,color: Colors.white),),
                  ),

                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Date", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("28-Mar-2023", style: TextStyle(fontSize: 15.0,color: Colors.white),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Time", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("12:00 PM", style: TextStyle(fontSize: 15.0,color: Colors.white),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Venue", style: TextStyle(fontSize: 15.0, color: Color(0xFFBEB7AA)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text("AB1", style: TextStyle(fontSize: 15.0,color: Colors.white),),
                  ),

                ],
              ),
            ],
          ),
        ),

        Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png'),
        height: 0.20 * MediaQuery.of(context).size.height,
        color: Color(0xFFBEB7AA),)


      ],
    );
  }
}

