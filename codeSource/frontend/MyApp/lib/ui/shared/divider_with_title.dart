import 'package:flutter/material.dart';

class DividerWithTitle extends StatelessWidget {
  final String title;

  DividerWithTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Divider(
            indent: 10,
            endIndent: 10,
          )),
          Text(title),
          Expanded(
              child: Divider(
            indent: 10,
            endIndent: 10,
          )),
        ],
      ),
    );
  }
}
