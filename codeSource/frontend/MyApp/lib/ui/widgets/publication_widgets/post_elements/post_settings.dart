import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';

class PostSettingsWidget extends StatelessWidget {

 final Publication publication;
 final Employee poster;
 PostSettingsWidget({this.publication,this.poster});

  @override
  Widget build(BuildContext context) {
    //      receiving the user object from the Stream      //
         Employee user = Provider.of<Employee>(context);
    ////////////////////////////////////////////////////////
    return BaseView<PostSettingsModel>(
          onModelReady: (model)=>model.initData(publication, poster, user, context),
          builder:(context,model,child)=> PopupMenuButton<SETTINGCHOICES>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          icon: Icon(Icons.expand_more),
          onSelected: model.applySettings,
          itemBuilder: (BuildContext context){
            return model.listOfChoices();
          }
        ),
    );

  }


}