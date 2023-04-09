import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'homeBody.dart';
import 'homeEventCard.dart';
import 'login.dart';

class CardRow extends StatefulWidget {
  List<event_list> list_of_events;
  var data;
  CardRow({
    Key? key,
    required this.list_of_events, required this.data,
  }) : super(key: key);

  @override
  State<CardRow> createState() => _CardRowState();
}

class _CardRowState extends State<CardRow> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      scrollDirection: Axis.horizontal,
      child: Row(

        children: widget.list_of_events
            .map((event) =>
        GestureDetector(
          child: EventCard(event_data: event, data: widget.data),
          onTap: (){},
        ))
            .toList(),
      ),
    );
  }
}
