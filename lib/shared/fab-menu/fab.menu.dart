import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';

Widget fabItem(IconData? icon, { dynamic onTap }) {
  return ClipOval(
      child: Material(
    color: Colors.white, // Button color
    child: InkWell(
      splashColor: Colors.white, // Splash color
      onTap: onTap ?? () {},
      child: SizedBox(
        width: 56,
        height: 56,
        child: Icon(icon, color: Colors.redAccent),
      ),
    ),
  ));
}
