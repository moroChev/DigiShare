import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostTextField extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Container(
              width: 340,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: TextField(
                controller: Provider.of<ToPostModel>(context, listen: false).contentController,
                maxLines: 4,
                decoration: InputDecoration(hintText: "text ...",border: InputBorder.none),
              ),
            );
  }
}