import 'package:dubai_events/service/data/events.api.service.dart';
import 'package:dubai_events/util/datetime/human.times.util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetailsPartial extends StatelessWidget {
  final EventModel event;

  const EventDetailsPartial({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(CupertinoIcons.map, color: Colors.grey, size: 10),
        ),
        Row(children: [
          Text("${event.location}, ",
              style: const TextStyle(color: Colors.grey)),
          Text(HumanTimes.getDate(event.timestamp),
              style: const TextStyle(color: Colors.grey)),
        ])
      ]),
      Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: const Icon(CupertinoIcons.tickets, color: Colors.grey, size: 10),
        ),
        Text("${event.ticketPrice} AED",
            style: const TextStyle(color: Colors.grey)),
      ])
    ]);
  }
}
