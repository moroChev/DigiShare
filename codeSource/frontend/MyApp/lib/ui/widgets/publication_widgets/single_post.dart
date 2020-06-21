import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_elements/post_Text.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/post_reactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './post_elements/post_emp_tile.dart';
import './post_elements/post_image_deco.dart';


class SinglePublicationWidget extends StatelessWidget {
  final Publication publication;
  final Employee poster;
  
  

  SinglePublicationWidget({@required this.publication, @required this.poster});

  @override
  Widget build(BuildContext context) {

  return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5),spreadRadius: 5,blurRadius: 7, offset: Offset(0, 3),),],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          EmployeeListTilePub(employee: poster, publication: publication),
          _postContent(),
          Divider(indent: 20,endIndent: 20,),
          PostReactions(publication: publication),
        ],
      ),
    );
  }

// this row is here for test if the post has an image or not
 Widget _postContent(){
   return publication?.imageUrl !=null ? Column(
     children: <Widget>[
          PostText(content: publication?.content),
          PostImage(imageUrl: publication?.imageUrl),
     ],
   ) : PostText(content: publication?.content);
 }



}
