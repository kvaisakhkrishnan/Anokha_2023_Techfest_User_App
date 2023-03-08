import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class RegisteredEventCard extends StatefulWidget {
  RegisteredEventCard({Key? key}) : super(key: key);
  bool selected = false;
  bool takeThere = false;
  @override
  State<RegisteredEventCard> createState() => _RegisteredEventCardState();
}

class _RegisteredEventCardState extends State<RegisteredEventCard> {


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
        transform: Matrix4.translationValues(
          0.0,
          widget.selected ? -100.0 : 0.0,
          0.0,
        ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: GestureDetector(
          onTap: (){
            setState(() {
              widget.selected = ! widget.selected;
            });
          },
          onLongPress: (){
            if(widget.selected == true){
                widget.takeThere = true;
            }
          },
          child: Container(

            constraints: BoxConstraints.expand(
              height: 280.0
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
              boxShadow:[BoxShadow(color: Colors.grey, spreadRadius: 0.5,blurRadius: 30.0)]
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Text("Eventide",
                      style: TextStyle(
                        fontSize: 23.0,

                      ),),
                    ), flex: 2,),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                      child: Image(image: AssetImage('./Images/logo.png')),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("CSE | Workshop",
                      style: TextStyle(
                        color: Color(0xFFFF3F11)
                      ),),
                    ),)
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text("ygdub3ed37tr83gf83ebdu93",
                  style: TextStyle(
                    fontSize: 23.0,

                  ),),
                ),

                Expanded(
                  child: Row(
                    children: [
                      Expanded(child:
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text("Valid on\n10-12-2001",
                        style: TextStyle(

                        ),),
                      )),

                      Expanded(child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Image(
                          image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png'),
                            color: Color(0xFFBEB7A4)
                        ),
                      ))
                    ],
                  ),
                )


              ],
            ),

          ),
        ),
      ),
    );
  }
}
