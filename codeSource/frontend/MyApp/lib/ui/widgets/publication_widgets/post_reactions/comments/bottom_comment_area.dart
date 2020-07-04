import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomCommentArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: Provider.of<SinglePostModel>(context, listen: false).commentTextController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(10.0)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Type message',
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.send,color: Colors.blue,),
              onPressed: () =>Provider.of<SinglePostModel>(context, listen: false).addComment()
              )
        ],
      ),
    );
  }
}
