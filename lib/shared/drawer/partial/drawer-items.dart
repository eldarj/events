import 'package:dubai_events/util/navigation/navigator.util.dart';
import 'package:flutter/material.dart';

Widget buildSectionTitle(String sectionTitle, { double topMargin = 15.0}) {
  return Container(
      padding: EdgeInsets.only(top: topMargin, left: 20),
      child: Text("$sectionTitle", style: TextStyle(fontSize: 12, color: Colors.grey)));
}

Widget buildDrawerItem(BuildContext context, String labelName, Widget iconWidget,
    {
      Widget? activity, dynamic onTapFunction, String labelDescription = '', crossAxisAlignment = CrossAxisAlignment.center,
      padding = const EdgeInsets.only(top: 10, bottom: 10, left: 20)
    }) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTapFunction ?? () {
        Navigator.pop(context);
        NavigatorUtil.push(context, activity);
      },
      child: Container(
        padding: padding,
        child: Row(
          crossAxisAlignment: crossAxisAlignment,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10),
                child: iconWidget),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(labelName, style: TextStyle(
                color: Colors.grey.shade700,
              )),
              labelDescription != null && labelDescription != '' ? Text(labelDescription, style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              )) : Container()
            ])
          ],
        ),
      ),
    ),
  );
}

Widget buildIcon({ IconData? icon, String? iconPath, Color backgroundColor = Colors.lightBlueAccent}) {
  return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Container(width: 40, height: 40, padding: EdgeInsets.all(10),
          child: icon != null ? Icon(icon, size: 20, color: Colors.white)
              : Image.asset(iconPath ?? '', height: 20, color: Colors.white)));
}
