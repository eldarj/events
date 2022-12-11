import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'activity/events/overview/events.overview.activity.dart';

late BuildContext rootContext;

late Size deviceMediaSize;
late EdgeInsets deviceMediaPadding;

void main() {
  runApp(const MyApp());
}

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
      ),
    );
  }
}
