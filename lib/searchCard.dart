import 'package:anokha_home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'homeBody.dart';

class SearchCard extends StatefulWidget {
  final events event_data;

  SearchCard({Key? key, required this.event_data}) : super(key: key);


  @override
  State<SearchCard> createState() => _SearchCard();
}

class _SearchCard extends State<SearchCard> {
  bool starred = false;
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1.0,
                        blurRadius: 10.0
                    )
                  ],
                  image: DecorationImage(
                      image: NetworkImage('https://play-lh.googleusercontent.com/VojafVZNddI6JvdDGWFrRmxc-prrcInL2AuBymsqGoeXjT4f9sv7KnetB-v3iLxk_Koi'),
                      fit: BoxFit.fill
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
              ),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.width * 0.4 * 1.0,
                  width: MediaQuery.of(context).size.width * 0.4
              ),


            ),
            Container(child:
            Row(

              children: [

                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Text(widget.event_data.name,

                        style: TextStyle(

                          fontSize: 20.0,
                        ),),
                      Text(widget.event_data.type,
                        style: TextStyle(

                        ),)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,

                  ),
                ),

                Expanded(
                  child: !starred? IconButton(
                      iconSize: 30.0,
                      alignment: Alignment.centerRight,
                      onPressed: (){
                        setState(() {
                          starred  = !starred;
                        });
                      },
                      icon: Icon(
                          Icons.star_border
                      ))
                      :
                  IconButton(
                      iconSize: 30.0,
                      alignment: Alignment.centerRight,
                      onPressed: (){
                        setState(() {
                          starred  = !starred;
                        });
                      },
                      icon: Icon(
                          Icons.star
                      )),
                )
              ],
            ),
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.width * 0.4 * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4
              ),
              decoration: (
                  BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1.0,
                            blurRadius: 10.0
                        )
                      ],
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0), bottomRight: Radius.circular(25.0))
                  )
              ),

            )

          ],

        ),
      );
  }
}
