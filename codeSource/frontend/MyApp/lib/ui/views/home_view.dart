import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './base_view.dart';
import '../../core/viewmodels/home_model.dart';
import '../shared/CustomAppBar.dart';
import '../../core/enum/viewstate.dart';
import '../widgets/publication_widgets/single_post.dart';
import 'package:MyApp/ui/shared/SideMenuWidget.dart';
import 'package:MyApp/ui/shared/floatingButton.dart';


class HomeView extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    return BaseView<HomeModel>(
      onModelReady: (model) => model.getAllPublications(),
      builder: (context, model, child) => Scaffold(
        drawer: SideMenuWidget(),   
        floatingActionButton: FloatingButton(),
        appBar: CustomAppBar.getAppBar(context),
        backgroundColor: Color(0xFFf4f6ff),
        //App background
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount  : model.publications.length,
                itemBuilder: (context,index){
                  return SinglePublicationWidget( publication: model.publications[index], poster: model.publications[index]?.postedBy);
                  }
              ),  
      ),
    );
  }
}
