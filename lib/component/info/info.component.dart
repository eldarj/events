import 'package:flutter/material.dart';

class InfoComponent extends StatelessWidget {
  final String text;
  final String imagePath;

  const InfoComponent(
    this.text, {
    required Key key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Container();

    iconWidget = Opacity(
        opacity: 0.8, child: Image.asset(imagePath, width: 150, height: 150));

    return Center(
      child: Container(
        width: 230,
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color.fromRGBO(255, 255, 255, 0),
                BlendMode.srcATop,
              ),
              child: iconWidget),
          Container(
              margin: const EdgeInsets.only(bottom: 20, top: 20),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              )),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  elevation: 1,
                  minimumSize: const Size(90, 40),
                  backgroundColor: Colors.green),
              child: const Text("buttonLabel",
                  style: TextStyle(color: Colors.white)))
        ]),
      ),
    );
  }

  static errorPanda(
      {onButtonPressed,
      message = 'Something went wrong, please try again',
      buttonLabel = 'Try again'}) {
    return InfoComponent(
      message,
      key: ValueKey(buttonLabel),
      imagePath: 'static/image/flag/uae.png',
    );
  }
}
