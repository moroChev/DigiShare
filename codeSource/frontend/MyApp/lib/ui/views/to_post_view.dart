
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/widgets/to_post_widgets/to_post_box/tp_post_box.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:MyApp/ui/shared/CustomAppBar.dart';
import 'package:MyApp/ui/shared/SideMenuWidget.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/ui/widgets/to_post_widgets/tp_create_btn.dart';
import 'package:MyApp/ui/widgets/to_post_widgets/tp_select_image_btn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ToPostView extends StatelessWidget {

   final Publication post;

   ToPostView({this.post});



  @override
  Widget build(BuildContext context) {
    
    Employee user = Provider.of<Employee>(context);
    
    return BaseView<ToPostModel>(
      onModelReady: (model)=>model.initData(post, user),
      builder: (context,model,child)=>
       model.state == ViewState.Idle ? 
        Scaffold(
        appBar: CustomAppBar.getAppBar(context),
        drawer: SideMenuWidget(),
        body: SingleChildScrollView(      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PublicationBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[ 
                CreateBtn(),
                SelectImageBtn(),
              ],
             ),
           ],
          ),
         )
        )
        :
        Center(
          child:CircularProgressIndicator(),
        ),
    );
  
  }
}
