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
  RiveAsset(artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Home"),
  RiveAsset(artboard: "SEARCH", stateMachineName: "SEARCH_Interactivity", title: "Search"),
  RiveAsset(artboard: "TIMER", stateMachineName: "TIMER_Interactivity", title: "Timer"),
  RiveAsset(artboard: "BELL", stateMachineName: "BELL_Interactivity", title: "Bell"),
  RiveAsset(artboard: "USER", stateMachineName: "USER_Interactivity", title: "Profile"),
];
