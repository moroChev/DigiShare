import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class PostTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ToPostModel>(
      builder:(context,model,child)=>Container(
      width: 340,
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
      child: TextField(
        controller: model.contentController,
        maxLines: 4,
        decoration: InputDecoration(hintText: "text ...",border: InputBorder.none),
      ),
      )
    );
  }
}