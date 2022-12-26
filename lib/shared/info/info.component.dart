import 'package:flutter/material.dart';

class InfoComponent extends StatelessWidget {
  final String text;
  final String buttonLabel;
  final String imagePath;
  final dynamic onButtonPressed;

  const InfoComponent(
    this.text,
    this.buttonLabel,
    this.onButtonPressed, {
    required Key key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = Container();

    iconWidget = Opacity(
        opacity: 0.8, child: Image.asset(imagePath, width: 100, height: 100));

    return Container(
      color: Colors.white,
      child: Center(
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
                onPressed: onButtonPressed,
                style: TextButton.styleFrom(
                    elevation: 1,
                    minimumSize: const Size(90, 40),
                    backgroundColor: Colors.redAccent),
                child: Text(buttonLabel,
                    style: const TextStyle(color: Colors.white)))
          ]),
        ),
      ),
    );
  }

  static errorPanda(
      {onButtonPressed,
      message = "Oops! We're sorry, something went wrong! Please try again.",
      buttonLabel = 'Try again'}) {
    return InfoComponent(
      message,
      buttonLabel,
      onButtonPressed ?? () {},
      key: ValueKey(buttonLabel),
      imagePath: 'static/image/illustration/error-cone.png',
    );
  }
}
