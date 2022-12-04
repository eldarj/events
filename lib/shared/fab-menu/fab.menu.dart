import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

var FabMenu = FabCircularMenu(
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
      fabItem(Icons.search),
    ]);

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
