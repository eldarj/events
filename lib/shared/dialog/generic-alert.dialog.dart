import 'package:flutter/material.dart';

class GenericAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  final String? positiveBtnText;
  final String? negativeBtnText;
  final Function? onPositivePressed;
  final Function? onNegativePressed;

  const GenericAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.positiveBtnText,
    this.negativeBtnText,
    this.onPositivePressed,
    this.onNegativePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        negativeBtnText != null
            ? TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onNegativePressed!();
                },
                child: Text(negativeBtnText!),
              )
            : Container(),
        positiveBtnText != null
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onPositivePressed!();
                  },
                  child: Text(positiveBtnText!),
                ),
              )
            : Container(),
      ],
    );
  }
}
