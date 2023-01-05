import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/util/datetime/human.times.util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildDateContainer(event, color) {
  Widget w = Container();
  var style = TextStyle(color: color, fontSize: 12);

  if (event.eventDate?.dateType == 'DoesNotRepeat') {
    w = Text(HumanTimes.getDate(event.eventDate?.dateMillis ?? 0),
        style: style);

  } else if (event.eventDate?.dateType == 'Daily') {
    var fromMillis = event.eventDate?.fromMillis ?? 0;
    var toMillis = event.eventDate?.toMillis ?? 0;

    var from = HumanTimes.getDate(fromMillis);
    var to = HumanTimes.getDate(toMillis);

    var fromYear = HumanTimes.getYear(fromMillis);
    var toYear = HumanTimes.getYear(toMillis);
    if (fromYear != toYear) {
      from = '$from, $fromYear';
      to = '$to, $toYear';
    }

    w = Text('Every day - Ends on $to',
        style: style);

  } else if (event.eventDate?.dateType == 'Weekly') {
    var weekDays = event.eventDate?.days.map((d) => d[0].toUpperCase() + d.toLowerCase().substring(1)).toList().join(', ');
    w = Text('Every $weekDays', style: style);
  }

  return w;
}

class EventDetailsPartial extends StatelessWidget {
  final EventModel event;

  Color? color;

  EventDetailsPartial({super.key, required this.event, this.color});

  @override
  Widget build(BuildContext context) {
    var _color = this.color ?? Colors.grey.shade700;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 2.5),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              child: Icon(CupertinoIcons.map, color: _color, size: 14),
            ),
          ),
          Flexible(
            child: Text("${event.eventLocation?.name}",
                style: TextStyle(color: _color)),
          ),
          Row(children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 5),
              child:
              Icon(CupertinoIcons.tickets, color: _color, size: 14),
            ),
            Text(event.ticketPrice > 0 ? "${event.ticketPrice} AED" : "Free",
                style: TextStyle(color: _color)),
          ])
        ]),
      ),
      Container(height: 3.5),
      Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
            margin: const EdgeInsets.only(right: 5),
            child: Icon(Icons.watch_later_outlined, color: _color, size: 14)),
        Flexible(child: buildDateContainer(event, _color))
      ]),
    ]);
  }
}
