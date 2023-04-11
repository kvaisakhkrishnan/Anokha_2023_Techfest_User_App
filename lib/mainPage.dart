import 'package:anokha_home/timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String assetName = 'Images/campus.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002845),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
                  child: Image.asset('Images/anokha_text_comp.png',width: MediaQuery.of(context).size.width * 0.8),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                  child: Transform.scale(
                    scale: 2.0,
                    child: SvgPicture.asset(
                      'Images/clg.svg',
                      semanticsLabel: 'My SVG Image',
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.33,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                  child: Text("Begins In",style: TextStyle(color: Colors.white,fontSize: 22.0)),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    children: [
                      Spacer(),
                      CountdownPage(onCountdownComplete: () {  },),
                      Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "ABOUT ANOKHA\n",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "Anokha, the national engineering techfest of Amrita School of Engineering, Coimbatore, is a 3-day congregation of some of the brightest minds in India. Founded in 2010, Anokha has grown by leaps and bounds and has progressed to become one of the most popular and top techfests in India. Having successfully completed eight editions, Anokha has had an average annual participation of over 10,000 of the best undergraduate engineering students from top-ranking engineering institutions in India like IITs, BITS, NITs and IIITs participating as well as partner universities in USA and Europe like University of New Mexico, EVRY France and Uppsala University-Sweden.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
