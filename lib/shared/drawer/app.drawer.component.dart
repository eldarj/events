import 'package:dubai_events/shared/base/base.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDrawerComponent extends StatefulWidget {
  const AppDrawerComponent({super.key});

  @override
  State<StatefulWidget> createState() => AppDrawerComponentState();
}

class AppDrawerComponentState extends BaseState<AppDrawerComponent> {
  @override
  Widget render() {
    return const Text("Drawer");
  }
}
