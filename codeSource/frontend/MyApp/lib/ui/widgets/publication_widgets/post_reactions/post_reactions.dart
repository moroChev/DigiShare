import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_reactions_model.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/post_likes_list.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/core/models/employee.dart';




class PostReactions extends StatelessWidget {

 final Publication publication;

 PostReactions({@required this.publication});
 
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<Employee>(context).id;
        return BaseView<PostReactionsModel>(
          onModelReady: (model) => model.initData(publication, userId),
          builder: (context, model, child) {  
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton.icon(
                      color: Colors.blue[60],
                      icon:  model.favoriteIcon(),
                      onLongPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LikesWidget(publicationId: publication?.id)));
                      },
                      label: Text("${model.nbrOfLikes}",style: TextStyle(color: Colors.grey[400],fontFamily: "Times"),),
                      onPressed: () => model.onPressLikeIcon(),
                   ),
                ],
              );
          }
        );
  }
}