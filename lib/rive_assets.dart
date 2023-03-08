import 'package:rive/rive.dart';

class RiveAsset{
  final String artboard, stateMachineName, title;
  late SMIBool? input;
  RiveAsset({
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input
  });
  set setInput (SMIBool status){
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(artboard: "HOME", stateMachineName: "HOME_interactivity", title: "Home"),
  RiveAsset(artboard: "LIKE/STAR", stateMachineName: "STAR_Interactivity", title: "Search"),
  RiveAsset(artboard: "TIMER", stateMachineName: "TIMER_Interactivity", title: "Timer"),
  RiveAsset(artboard: "USER", stateMachineName: "USER_Interactivity", title: "Profile"),
];
