import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';

import 'package:MyApp/core/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomCommentArea extends StatelessWidget {

  final TextEditingController commentTextCtrl;
  final Comment singleComment;
  BottomCommentArea({@required this.singleComment,@required this.commentTextCtrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: this.commentTextCtrl,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Type message',
                  ),
                ),
              ),
              this.singleComment == null
                  ? 
                  IconButton(
                      icon: Icon(Icons.send,color: Colors.blue),
                      onPressed: () =>Provider.of<SinglePostModel>(context, listen: false).addComment()
                      )
                  : Container(height: 0,width: 0)
            ],
          ),
          this.singleComment != null ?
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () =>
                          Provider.of<SinglePostModel>(context, listen: false)
                              .cancelEditingComment(),
                        child: Text('Annuler',style: TextStyle(fontFamily: "Times")),
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Colors.white,
                        onPressed: () => Provider.of<SinglePostModel>(context, listen: false).saveEditingComment(),
                        child: Text('Enregistrer',style: TextStyle(fontFamily: "Times"),),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
