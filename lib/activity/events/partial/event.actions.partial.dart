import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/util/snackbar/snackbar.handler.util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class EventActionsPartial extends StatelessWidget {

  final EventModel event;
  final Function setState;

  const EventActionsPartial({super.key, required this.event, required this.setState});

  @override
  Widget build(BuildContext context) {
    return                       Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => addToCalendar(event),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.redAccent,
                ),
                child: const Text('Add to Calendar'),
              ),
              Row(children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        event.saved = !event.saved;
                      });
                      SnackbarHandler.show(context,
                          text: 'Event saved to Wishlist');
                    },
                    icon: Icon(
                        event.saved
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        color: event.saved
                            ? Colors.yellow.shade600
                            : Colors.grey.shade400)),
                IconButton(
                    onPressed: () {
                      Share.share(event.reservationUrl); // TODO: Implement location sharing
                    },
                    icon: Icon(
                        CupertinoIcons
                            .arrowshape_turn_up_right,
                        color: Colors.grey.shade400)),
              ])
            ])
    );
  }

  void addToCalendar(EventModel event) {
    Add2Calendar.addEvent2Cal(Event(
      title: event.name,
      description: event.description,
      location: event.eventLocation?.name ?? 'Dubai Events',
      startDate:
      DateTime.fromMillisecondsSinceEpoch(event.eventTimestamp),
      endDate: DateTime.fromMillisecondsSinceEpoch(event.eventTimestamp),
    ));
  }
}