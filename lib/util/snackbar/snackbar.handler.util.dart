import 'package:flutter/material.dart';

class SnackbarHandler {
  static show(BuildContext context, {required String text, Color? textColor, Icon? icon}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 1.5,
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
      backgroundColor: Colors.grey.shade100,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontFamily: 'Ubuntu', color: textColor ?? Colors.black87)),
          icon ?? Container()
        ],
      ),
    ));
  }
}
