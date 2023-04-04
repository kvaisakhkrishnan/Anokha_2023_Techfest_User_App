import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnokhaCards extends StatefulWidget {
  const AnokhaCards({Key? key}) : super(key: key);

  @override
  State<AnokhaCards> createState() => _AnokhaCardsState();
}

class _AnokhaCardsState extends State<AnokhaCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
      child: Row(
        children: [


          Column(
            children: [
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://www.whats-on-netflix.com/wp-content/uploads/2023/02/renewed-netflix-shows-2023-beyond-jpg.webp'),
                      fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFFEFECF0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 10.0
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.width * 0.50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text("Event Name",
                style: TextStyle(fontSize: 20.0,
                fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://www.whats-on-netflix.com/wp-content/uploads/2023/02/renewed-netflix-shows-2023-beyond-jpg.webp'),
                      fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFFEFECF0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 10.0
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.width * 0.50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text("Event Name",
                  style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://www.whats-on-netflix.com/wp-content/uploads/2023/02/renewed-netflix-shows-2023-beyond-jpg.webp'),
                      fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFFEFECF0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 10.0
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.width * 0.50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text("Event Name",
                  style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://www.whats-on-netflix.com/wp-content/uploads/2023/02/renewed-netflix-shows-2023-beyond-jpg.webp'),
                      fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFFEFECF0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 10.0
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.width * 0.50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text("Event Name",
                  style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('https://www.whats-on-netflix.com/wp-content/uploads/2023/02/renewed-netflix-shows-2023-beyond-jpg.webp'),
                      fit: BoxFit.cover,),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xFFFEFECF0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1.0,
                          blurRadius: 10.0
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.width * 0.50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text("Event Name",
                  style: TextStyle(fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),


        ],
      )),
    );
  }
}
