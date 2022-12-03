import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_events/activity/events/partial/event.actions.partial.dart';
import 'package:dubai_events/activity/events/partial/event.details.partial.dart';
import 'package:dubai_events/activity/events/single/single.event.activity.dart';
import 'package:dubai_events/service/client/http.client.dart';
import 'package:dubai_events/service/data/events.location.model.dart';
import 'package:dubai_events/service/client/http.response.extension.dart';
import 'package:dubai_events/service/data/events.model.dart';
import 'package:dubai_events/shared/activity-title/activity.title.component.dart';
import 'package:dubai_events/shared/base/base.state.dart';
import 'package:dubai_events/shared/info/info.component.dart';
import 'package:dubai_events/shared/layout/horizontal.line.component.dart';
import 'package:dubai_events/shared/loader/spinner.component.dart';
import 'package:dubai_events/util/navigation/navigator.util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventsOverviewActivity extends StatefulWidget {
  const EventsOverviewActivity({super.key});

  @override
  State<StatefulWidget> createState() => EventsOverviewActivityState();
}

class EventsOverviewActivityState extends BaseState<EventsOverviewActivity> {
  List<EventModel> events = [];

  initialize() async {
    setState(() {
      displayLoader = true;
    });

    doGetEvents().then(onGetEventsSuccess, onError: onGetEventsError);
  }

  @override
  initState() {
    super.initState();
    initialize();
  }

  @override
  deactivate() {
    super.deactivate();
  }

  @override
  Widget render() {
    Widget widget = const SpinnerComponent();

    if (!displayLoader) {
      if (!isError) {
        widget = Container(
          color: Colors.white,
          child: Column(
            children: [
              events.isNotEmpty
                  ? buildListView()
                  : Container(
                      margin: const EdgeInsets.all(25),
                      child: const Text('No events to display',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey)),
                    )
            ],
          ),
        );
      } else {
        widget = InfoComponent.errorPanda(onButtonPressed: () async {
          setState(() {
            displayLoader = true;
            isError = false;
          });

          doGetEvents().then(onGetEventsSuccess, onError: onGetEventsError);
        });
      }
    }

    return widget;
  }

  // Content
  Widget buildListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: events.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ActivityTitleComponent(
                title: "Upcoming Events",
                actionWidget: Image.asset('static/image/company/dubai-xs.png',
                    height: 20));
          }

          if (index == events.length + 1) {
            return Container(height: 75);
          }

          return buildSingleEventRow(events[index - 1]);
        },
      ),
    );
  }

  Widget buildSingleEventRow(EventModel event) {
    var eventImageWidget = CachedNetworkImage(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      imageUrl: event.coverImageUrl,
      placeholder: (context, url) => Container(
          alignment: Alignment.center,
          height: 25,
          width: 25,
          child: const CircularProgressIndicator(color: Colors.redAccent)),
      errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined, color: Colors.grey),
    );

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          NavigatorUtil.push(
              context,
              SingleEventActivity(
                  event: event, prebuiltImageWidget: eventImageWidget));
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: SizedBox(height: 400, child: eventImageWidget)),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    border:
                        Border.all(color: Colors.grey.shade400, width: 0.5)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54)),
                      EventDetailsPartial(event: event),
                      const HorizontalLine(),
                      Text(
                          event.shortDescription.length > 200
                              ? "${event.shortDescription.substring(0, 200)}..."
                              : event.shortDescription,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black54)),
                      EventActionsPartial(event: event, setState: setState)
                    ]))
          ]),
        ),
      ),
    );
  }

  // Data calls
  Future doGetEvents() async {
    String url = "/api/events";
    http.Response? response = await HttpClient.get(url);

    await Future.delayed(const Duration(milliseconds: 500));

    if(response != null && response.statusCode != 200) {
      throw Exception();
    }

    dynamic result = response?.decode();

    return result;
  }

  void onGetEventsSuccess(result) async {
    print(result);
    events = EventModel.fromJsonList(result);
    print(events);

    setState(() {
      displayLoader = false;
      isError = false;
    });
  }

  void onGetEventsError(Object error) async {
    print(error);
    setState(() {
      displayLoader = false;
      isError = true;
    });
  }
}
