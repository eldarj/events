import 'package:flutter/material.dart';

class SpinnerComponent extends StatelessWidget {
  const SpinnerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey)));
  }
}
