import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityTitleComponent extends StatelessWidget {
  final String title;

  final Widget? actionWidget;

  const ActivityTitleComponent(
      {super.key, required this.title, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12.5, 15, 10, 10),
      alignment: Alignment.bottomLeft,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title,
            style: const TextStyle(
                color: Color(0xCC000000),
                fontSize: 21,
                fontFamily: "Ubuntu",
                fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: actionWidget,
        ),
      ]),
    );
  }
}