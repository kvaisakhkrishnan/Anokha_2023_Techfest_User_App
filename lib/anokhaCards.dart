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
    return SingleChildScrollView(scrollDirection: Axis.horizontal,
    child: Row(
      children: [

      ],
    ));
  }
}
