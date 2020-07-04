import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:MyApp/core/enum/PostSettingsEnum.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';

class PostSettingsWidget extends StatelessWidget {


 PostSettingsWidget();

  @override
  Widget build(BuildContext context) {
    //      receiving the user object from the Stream      //
    //     Employee user = Provider.of<Employee>(context);
    ////////////////////////////////////////////////////////
    return  PopupMenuButton<SETTINGCHOICES>(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          icon: Icon(Icons.expand_more),
          onSelected: Provider.of<SinglePostModel>(context, listen: false).applySettings,
          itemBuilder: (BuildContext context){
            return Provider.of<SinglePostModel>(context, listen: false).listOfChoices();
          }
    );

  }


}