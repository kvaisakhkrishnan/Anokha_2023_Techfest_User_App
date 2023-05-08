import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


//Animated Navigation Bar

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color(0xFFFF7F11),
      ),);
  }
}
