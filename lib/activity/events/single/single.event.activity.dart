import 'package:dubai_events/shared/activity-title/activity.title.component.dart';
import 'package:dubai_events/main.dart';
import 'package:dubai_events/service/data/events.api.service.dart';
import 'package:dubai_events/util/widget/base.state.dart';
import 'package:flutter/material.dart';

class SingleEventActivity extends StatefulWidget {
  final EventModel event;

  final Widget prebuiltImageWidget;

  const SingleEventActivity(
      {super.key, required this.event, required this.prebuiltImageWidget});

  @override
  State<StatefulWidget> createState() => SingleEventActivityState();
}

class SingleEventActivityState extends BaseState<SingleEventActivity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,appBar: AppBar(
      leading: const CloseButton(),
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),body: Builder(builder: (context) {
      scaffold = Scaffold.of(context);
      return render();
    }));
  }

  @override
  Widget render() {
    return ListView(padding: EdgeInsets.zero, children: [
      Container(
          height: 400,
          decoration: const BoxDecoration(color: Colors.white),
          child: widget.prebuiltImageWidget),
      Container(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          color: Colors.white,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextButton(
              child: const Text("Message"),
              onPressed: () async {},
            ),
            TextButton(
              child: const Text("Phone call"),
              onPressed: () async {},
            ),
          ])),
      Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: const Text("Details")),
      Container(height: 500),
    ]);
  }
}
