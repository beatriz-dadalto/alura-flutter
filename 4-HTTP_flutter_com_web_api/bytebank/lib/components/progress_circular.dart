import 'package:flutter/material.dart';

class ProgressCircular extends StatelessWidget {
  final String message;

  ProgressCircular({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[CircularProgressIndicator(), Text(message)],
      ),
    );
  }
}
