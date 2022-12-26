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
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              child: Icon(CupertinoIcons.map, color: Colors.grey.shade700, size: 14),
            ),
          ),
          Flexible(
            child: Text("${event.eventLocation?.name}",
                style: TextStyle(color: Colors.grey.shade700)),
          ),
          Row(children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 5),
              child:
              Icon(CupertinoIcons.tickets, color: Colors.grey.shade700, size: 14),
            ),
            Text(event.ticketPrice > 0 ? "${event.ticketPrice} AED" : "Free",
                style: TextStyle(color: Colors.grey.shade700)),
          ])
        ]),
      ),
      Container(height: 3.5),
      Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
            margin: const EdgeInsets.only(right: 5),
            child: Icon(Icons.watch_later_outlined, color: Colors.grey.shade700, size: 14)),
        Flexible(child: buildDateContainer())
      ]),
    ]);
  }

  Widget buildDateContainer() {
    Widget w = Container();

    if (event.eventDate?.dateType == 'DoesNotRepeat') {
      w = Text(HumanTimes.getDate(event.eventDate?.dateMillis ?? 0),
          style: TextStyle(color: Colors.grey.shade700));

    } else if (event.eventDate?.dateType == 'Daily') {
      var from = HumanTimes.getDate(event.eventDate?.fromMillis ?? 0);
      var to = HumanTimes.getDate(event.eventDate?.toMillis ?? 0);
      w = Text('From $from To $to',
          style: TextStyle(color: Colors.grey.shade700));

    } else if (event.eventDate?.dateType == 'Weekly') {
      var weekDays = event.eventDate?.days.map((d) => d[0].toUpperCase() + d.toLowerCase().substring(1)).toList().join(', ');
      w = Text('Every $weekDays',
          style: TextStyle(color: Colors.grey.shade700));
    }

    return w;
  }
}
