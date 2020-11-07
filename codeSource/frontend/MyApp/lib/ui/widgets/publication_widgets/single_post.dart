import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_list_tile.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_elements/post_Text.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_elements/post_settings.dart';
import 'package:MyApp/ui/widgets/publication_widgets/post_reactions/post_reactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './post_elements/post_image_deco.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';

import 'package:provider/provider.dart';

class SinglePublicationWidget extends StatelessWidget {
  
  final Publication publication;
  final Employee poster;

  SinglePublicationWidget({@required this.publication, @required this.poster});

  @override
  Widget build(BuildContext context) {
    Employee user = Provider.of<Employee>(context);
    return BaseView<SinglePostModel>(
          onModelReady: (model)=>model.initData(publication, poster,user,context),
          builder:(context,model,child) => model.isHidden ? Container(height: 0,width: 0,)
          : Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: publication.isApproved ? Colors.white : Color(0xFFbdbdbd), width: 2.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300].withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            EmployeeListTile(
              employee: poster,
              subtitle: poster?.agency?.name,
              trailing: PostSettingsWidget(
                icon: Icon(Icons.expand_more),
                onSelected: model.applySettings,
                listOfChoices: listOfChoices(user),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Profil', arguments: poster.id);
              },
            ),
            _postContent(),
            Divider(
              indent: 20,
              endIndent: 20,
            ),
            PostReactions(),
          ],
        ),
      ),
    );
  }

// this row is here for test if the post has an image or not
  Widget _postContent() {
    return publication?.imageUrl != null
        ? Column(
            children: <Widget>[
              PostText(content: publication?.content),
              PostImage(imageUrl: publication?.imageUrl),
            ],
          )
        : PostText(content: publication?.content);
  }




  List<PopupMenuItem<SETTINGCHOICES>> listOfChoices(Employee user){

    List<PopupMenuItem<SETTINGCHOICES>> mychoices = [
           PopupMenuItem(value: SETTINGCHOICES.HIDE,child: Text("Masquer"),)
       ];

if(this.poster.id == user.id){

  mychoices.addAll([
          PopupMenuItem(value: SETTINGCHOICES.MODIFY,child: Text("Modifier",style: TextStyle(fontFamily: "Times"))),
          PopupMenuItem(value: SETTINGCHOICES.REMOVE,child: Text("Supprimer",style: TextStyle(fontFamily: "Times")))
          ]);
  }

if(user.canApprove && user.agency.id == poster.agency.id){
  if(publication.isApproved){
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Disapprouver",style: TextStyle(fontFamily: "Times"))));
  }else{
     mychoices.add(PopupMenuItem(value: SETTINGCHOICES.APPROVE,child: Text("Approuver",style: TextStyle(fontFamily: "Times"))));
  }
}
    return mychoices;
} 





}
