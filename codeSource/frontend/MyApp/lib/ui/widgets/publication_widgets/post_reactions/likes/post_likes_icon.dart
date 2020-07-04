import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/likes/post_likes_list.dart';


class PostLikesIcon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String postId = Provider.of<SinglePostModel>(context, listen: false).publication.id;
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Provider.of<SinglePostModel>(context, listen: false).favoriteIcon(),
                  onLongPress: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>LikesWidget(publicationId: postId))),
                  onTap: () => Provider.of<SinglePostModel>(context, listen: false).onPressLikeIcon(),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("${Provider.of<SinglePostModel>(context, listen: false).nbrOfLikes}",style:TextStyle(color: Colors.grey[400], fontFamily: "Times"),
                    )),
              ],
            ),
          );
  }
}