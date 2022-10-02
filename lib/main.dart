import 'package:dubai_events/util/snackbar/snackbar.handler.util.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake/shake.dart';

import 'activity/events/overview/events.overview.activity.dart';

late BuildContext rootContext;

late Size deviceMediaSize;
late EdgeInsets deviceMediaPadding;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool initialized = false;

  MyApp({super.key});

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

          if (!initialized) {
            initialized = true;
            initializeShakeDetection();
          }

          return const EventsOverviewActivity();
        }),
        floatingActionButton: FabCircularMenu(
            fabElevation: 1.0,
            fabColor: Colors.redAccent,
            fabOpenIcon: const Icon(Icons.menu_rounded, color: Colors.white),
            fabCloseIcon: const Icon(Icons.close_rounded, color: Colors.white),
            ringColor: const Color(0xEEFF5252),
            ringWidth: 100,
            ringDiameter: 400,
            children: [
              fabItem(Icons.star_border_rounded),
              fabItem(Icons.notifications_none_rounded),
              fabItem(Icons.person),
              fabItem(Icons.calendar_today),
            ]),
      ),
    );
  }

  Widget fabItem(IconData? icon) {
    return ClipOval(
        child: Material(
      color: Colors.white, // Button color
      child: InkWell(
        splashColor: Colors.white, // Splash color
        onTap: () {},
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(icon, color: Colors.redAccent),
        ),
      ),
    ));
  }
}

initializeShakeDetection() {
  ShakeDetector.autoStart(onPhoneShake: () {
    SnackbarHandler.show(rootContext, text: """
        🎉 Congrats, You won the Hidden Shaker Award! We'll send you the gift to your inbox shortly.
        """);
  });
}
