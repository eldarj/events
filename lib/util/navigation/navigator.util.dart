import 'package:flutter/material.dart';

class NavigatorUtil {
  static push(context, activity) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => activity));
  }
}
