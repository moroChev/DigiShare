import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/material.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/likes/post_likes_icon.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/comments/post_comment_icon.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/shares/post_share_icon.dart';

class PostReactions extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PostLikesIcon(),
              PostCommentIcon(),
            ],
          ),
          Row(
            children: <Widget>[
              PostShareIcon(),
            ],
          ),  
        ],
      ),
    );
  }
}
