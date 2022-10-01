import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ScaffoldState? scaffold;

  bool displayLoader;
  bool isError;

  BaseState({this.scaffold, this.displayLoader = false, this.isError = false});

  BuildContext? getScaffoldContext() => scaffold?.context;

  @override
  Widget build(BuildContext context) {
    preRender();

    return Scaffold(body: Builder(builder: (context) {
      scaffold = Scaffold.of(context);
      return render();
    }));
  }

  Widget render() {
    return displayLoader ? buildSpinner() : Container();
  }

  Widget buildSpinner() {
    return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey)));
  }

  preRender() {}
}
