 import 'package:anokha_home/homePage.dart';
import 'package:anokha_home/registerPage.dart';
import 'package:anokha_home/registeredEvents.dart';
import 'package:anokha_home/rive_assets.dart';
import 'package:anokha_home/starred_events.dart';
import 'package:anokha_home/user_profile.dart';
import 'package:anokha_home/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

import 'animated_bar.dart';
import 'crew_members.dart';


 class User {
   final String userEmail;
   final String fullName;
   final int activePassport;
   final int isAmritaCBE;
   final String collegeName;
   final String district;
   final String state;
   final String country;
   final String SECRET_TOKEN;

   @override
   String toString() {
     return 'User{userEmail: $userEmail, fullName: $fullName, activePassport: $activePassport, isAmritaCBE: $isAmritaCBE, collegeName: $collegeName, district: $district, state: $state, country: $country}';
   }

   User({
     required this.userEmail,
     required this.fullName,
     required this.activePassport,
     required this.isAmritaCBE,
     required this.collegeName,
     required this.district,
     required this.state,
     required this.country,
     required this.SECRET_TOKEN


   });
 }
class ControllerPage extends StatefulWidget {
  final User data;
  ControllerPage({required this.data});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  RiveAsset selectedBottomNav = bottomNavs.first;
  int selectedIndex = 0;
  var gravatar = Gravatar('cb.en.u4cse20142@cb.students.amrita.edu');
  var gravatar_url = "";


  @override
  void initState() {

    var url = gravatar.imageUrl(
      size: 100,
      defaultImage: GravatarImage.identicon,
      rating: GravatarRating.pg,
      fileExtension: true,
    );

    gravatar_url = url;


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(left: 24, right: 24),
          decoration: BoxDecoration(
            color: Color(0xFF203354),
            borderRadius: BorderRadius.all(Radius.circular(24)),

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ...List.generate(
                bottomNavs.length,
                    (index) => GestureDetector(
                  onTap: (){
                    bottomNavs[index].input!.change(true);
                    if(bottomNavs[index] != selectedBottomNav)
                    {
                      setState(() {

                        selectedBottomNav = bottomNavs[index];
                        selectedIndex = index;
                      });
                    }
                    Future.delayed(Duration(seconds: 1), (){
                      bottomNavs[index].input!.change(false);
                    });
                  },
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(isActive: bottomNavs[index] == selectedBottomNav),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity: bottomNavs[index] == selectedBottomNav ?
                          1 : 0.5,
                          child: RiveAnimation.asset("./RiveAssets/icons.riv",
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard){
                              StateMachineController controller = RiverUtils.getRiveController(
                                  artboard,
                                  stateMachineName: bottomNavs[index].stateMachineName);
                              bottomNavs[index].input = controller.findSMI("active") as SMIBool;

                            },
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              )

            ],
          ),

        ),
      ),
      body: navigationDecider(selectedIndex),
    );
  }


  Widget navigationDecider(int index){
    switch (index){
      case 0:
        return HomeWidget();
      case 1:
        return StarredEvents();
      case 2:
        return RegisteredEvents();
      case 3:
        return userProf(avatarLink: gravatar_url,);
      case 4:
        return GetCrew();
      default:
        return Text("Dummy Widget");
    }
  }

}
