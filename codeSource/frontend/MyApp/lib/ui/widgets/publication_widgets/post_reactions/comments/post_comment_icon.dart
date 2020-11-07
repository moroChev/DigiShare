import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MyApp/ui/views/single_post_view.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';
import 'package:provider/provider.dart';


class PostCommentIcon extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    print('PostCommentIcon .....');
    String pubId = Provider.of<SinglePostModel>(context, listen: false).publication.id;
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Icon(FontAwesomeIcons.comment,color: Colors.grey[400],size: 20.0,),
                  onTap: () => Navigator.pushNamed(context, '/SinglePostView',arguments: pubId),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("${Provider.of<SinglePostModel>(context, listen: false).nbrOfComments}",style:TextStyle(color: Colors.grey[400], fontFamily: "Times"),
                    )),
              ],
            ),
    );
  }
}