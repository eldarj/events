import 'package:dubai_events/shared/fab-menu/fab.menu.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'activity/events/overview/events.overview.activity.dart';
import 'event-bus/menu-events.publisher.dart';

late BuildContext rootContext;

late Size deviceMediaSize;
late EdgeInsets deviceMediaPadding;

void main() {
  runApp(const MyApp());
}

final GlobalKey<FabCircularMenuState> globalFabKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    var themeData = ThemeData(
      fontFamily: 'Roboto',
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      accentColorBrightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Dubai Events',
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(builder: (context) {
          rootContext = context;
          deviceMediaSize = MediaQuery.of(context).size;
          deviceMediaPadding = MediaQuery.of(context).padding;

          return const EventsOverviewActivity();
        }),
        floatingActionButton: FabCircularMenu(
            key: globalFabKey,
            fabElevation: 1.0,
            fabColor: Colors.redAccent,
            fabOpenIcon: const Icon(Icons.menu_rounded, color: Colors.white),
            fabCloseIcon: const Icon(Icons.close_rounded, color: Colors.white),
            ringColor: const Color(0xEEFF5252),
            ringWidth: 100,
            ringDiameter: 400,
            children: [
              fabItem(Icons.more_vert_rounded),
              fabItem(Icons.notifications_none_rounded),
              fabItem(Icons.bookmark_border_rounded),
              fabItem(Icons.search, onTap: () {
                globalFabKey.currentState?.close();
                menuEventsPublisher.emitMenuItemPressed(MenuItemType.SEARCH);
              }),
            ]),
      ),
    );
  }
}
