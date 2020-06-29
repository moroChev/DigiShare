import 'package:flutter/material.dart';

class PostText extends StatelessWidget {
  final String content;

  PostText({@required this.content});

  @override
  Widget build(BuildContext context) {
    String myContent = content ?? "";
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(32, 3, 18, 10),
      child: Text("$myContent", style: TextStyle(fontFamily: "Times")),
    );
  }
}
