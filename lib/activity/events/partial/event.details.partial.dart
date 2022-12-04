import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/util/datetime/human.times.util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetailsPartial extends StatelessWidget {
  final EventModel event;

  const EventDetailsPartial({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 2.5),
        child: Row(children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Icon(CupertinoIcons.map, color: Colors.grey.shade400, size: 14),
          ),
          Row(children: [
            Text("${event.eventLocation?.name}",
                style: const TextStyle(color: Colors.grey)),
            Container(
                margin: const EdgeInsets.only(left: 10, right: 5),
                child: Icon(Icons.watch_later_outlined, color: Colors.grey.shade400, size: 14)),
            Text(HumanTimes.getDate(event.eventTimestamp),
                style: const TextStyle(color: Colors.grey))
          ])
        ]),
      ),
      Container(height: 2.5),
      Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child:
              Icon(CupertinoIcons.tickets, color: Colors.grey.shade400, size: 14),
        ),
        Text(event.ticketPrice > 0 ? "${event.ticketPrice} AED" : "Free of Charge",
            style: const TextStyle(color: Colors.grey)),
      ])
    ]);
  }
}
