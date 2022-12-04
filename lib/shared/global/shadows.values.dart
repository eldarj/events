
import 'package:flutter/material.dart';

class Shadows {
  static bottomShadow(
      {color, double blurRadius = 1.5, double spreadRadius = 0, double topDistance = 5}) {
    return BoxShadow(
        color: color ?? Colors.grey.shade100,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        offset: Offset.fromDirection(1, topDistance));
  }
}