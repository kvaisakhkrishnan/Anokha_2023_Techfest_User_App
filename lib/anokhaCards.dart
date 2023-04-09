import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnokhaCards extends StatefulWidget {
  var data;
  AnokhaCards({Key? key, required List<dynamic> this.data}) : super(key: key);

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
                    image: DecorationImage(image: NetworkImage(widget.data[0].url),
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
                child: Text(widget.data[0].name,
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
                    image: DecorationImage(image: NetworkImage(widget.data[1].url),
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
                child: Text(widget.data[1].name,
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
                    image: DecorationImage(image: NetworkImage(widget.data[2].url),
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
                child: Text(widget.data[2].name,
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
                    image: DecorationImage(image: NetworkImage(widget.data[3].url),
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
                child: Text(widget.data[3].name,
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
                    image: DecorationImage(image: NetworkImage(widget.data[4].url),                      fit: BoxFit.cover,),
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
                child: Text(widget.data[4].name,
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
