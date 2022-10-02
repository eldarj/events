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
      margin: const EdgeInsets.fromLTRB(12.5, 20, 10, 20),
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

class ActivityTitleLeadingComponent extends StatelessWidget {
  final String title;

  final Widget? actionWidget;

  final Widget leading;

  const ActivityTitleLeadingComponent(
      {super.key, required this.leading, this.title = '', this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      alignment: Alignment.bottomLeft,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        leading,
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
