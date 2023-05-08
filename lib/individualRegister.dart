import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



//Registration form to register for each events.
class RegisterIndividualPage extends StatefulWidget {
  const RegisterIndividualPage({Key? key}) : super(key: key);

  @override
  State<RegisterIndividualPage> createState() => _RegisterIndividualPageState();
}

class _RegisterIndividualPageState extends State<RegisterIndividualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,toolbarHeight: 0,elevation: 0,),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Full Name",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 3, bottom: 3, right: 20),
                  child: TextFormField(

                    style: TextStyle(
                        fontSize: 19
                    ),

                    decoration: InputDecoration(
                      border: InputBorder.none,

                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Full Name",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(30.0)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 3, bottom: 3, right: 20),
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 19
                    ),

                    decoration: InputDecoration(
                      border: InputBorder.none,

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
