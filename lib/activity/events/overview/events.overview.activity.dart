import 'package:cached_network_image/cached_network_image.dart';
import 'package:dubai_events/component/drawer/app.drawer.component.dart';
import 'package:dubai_events/component/info/info.component.dart';
import 'package:dubai_events/component/loader/spinner.component.dart';
import 'package:dubai_events/service/data/events.api.service.dart';
import 'package:dubai_events/util/datetime/human.times.util.dart';
import 'package:dubai_events/util/widget/base.state.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const AppDrawerComponent(),
        body: Builder(builder: (context) {
          scaffold = Scaffold.of(context);
          return buildActivityContent();
        }));
  }

  // Main Content
  Widget buildActivityContent() {
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
            return Container(
              margin: const EdgeInsets.fromLTRB(10, 25, 10, 10),
              alignment: Alignment.bottomLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Upcoming Events",
                    style: TextStyle(
                        color: Color(0xAA000000),
                        fontSize: 23,
                        fontWeight: FontWeight.bold)),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                      'static/image/company/dubai-xs.png', height: 20),
                ),
              ]),
            );
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
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () async {
          await Future.delayed(const Duration(milliseconds: 250));
        },
        child: Container(
          padding:
          const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
                height: 200,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  imageUrl: event.imagePath,
                  placeholder: (context, url) =>
                      Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 25,
                          child: const CircularProgressIndicator(
                              color: Colors.redAccent)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.grey.shade400, width: 0.5)),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(event.name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                      ),
                      Row(
                        children: [
                          Text(HumanTimes.getDate(event.timestamp),
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                        event.description.length > 200
                            ? "${event.description.substring(0, 200)}..."
                            : event.description,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54)),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: const StadiumBorder(),
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text(
                                  "Add to calendar",
                                )),
                            TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.redAccent),
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: const Text("Share", style: TextStyle(
                                        fontSize: 16,
                                      )),
                                    ),
                                    Icon(Icons.send),
                                  ]
                                )),

                          ]))
                ]))
          ]),
        ),
      ),
    );
  }


  // Data calls
  Future doGetEvents() async {
    List<EventModel> events = EventsAPIService.getEvents();

    await Future.delayed(const Duration(seconds: 2));

    return events;
  }

  void onGetEventsSuccess(result) async {
    print(result);

    events = result;

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
