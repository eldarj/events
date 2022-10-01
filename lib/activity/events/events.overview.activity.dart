import 'package:dubai_events/component/info/info.component.dart';
import 'package:dubai_events/util/widget/base.state.dart';
import 'package:flutter/material.dart';

class EventsOverviewActivity extends StatefulWidget {
  const EventsOverviewActivity({super.key});

  @override
  State<StatefulWidget> createState() => EventsOverviewActivityState();
}

class EventsOverviewActivityState extends BaseState<EventsOverviewActivity> {
  initialize() async {
    setState(() {
      displayLoader = true;
    });
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

  Widget buildActivityContent() {
    Widget widget = InfoComponent.errorPanda(onButtonPressed: () async {
      setState(() {
        displayLoader = true;
        isError = false;
      });
    });

    if (!displayLoader) {
      if (!isError) {
        widget = Container(
          color: Colors.white,
          child: const Text("Hello"),
        );
      }
    }

    return widget;
  }
}
