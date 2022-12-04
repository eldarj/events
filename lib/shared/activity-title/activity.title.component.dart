import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityTitleComponent extends StatelessWidget {
  final String title;

  final Widget? actionWidget;

  final Widget? leading;

  const ActivityTitleComponent(
      {super.key, required this.title, this.leading, this.actionWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Row(children: [
          leading ?? Container(),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(title,
                style: const TextStyle(
                    color: Color(0xCC000000),
                    fontSize: 21,
                    fontFamily: "Ubuntu",
                    fontWeight: FontWeight.bold)),
          ),
        ]),
        Container(
          child: actionWidget,
        ),
      ]),
    );
  }
}