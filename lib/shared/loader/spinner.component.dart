import 'package:flutter/material.dart';

class SpinnerComponent extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;

  const SpinnerComponent({super.key, this.size = 35, this.strokeWidth = 4.0, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            backgroundColor: Colors.grey.shade300,
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color)));
  }
}
