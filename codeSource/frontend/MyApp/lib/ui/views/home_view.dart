import 'package:MyApp/ui/shared/sliverAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './base_view.dart';
import '../../core/viewmodels/home_model.dart';
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
        drawer: SideMenuWidget(model: model),
        floatingActionButton: FloatingButton(),
        backgroundColor: Color(0xFFF5F5F8),
        body: CustomScrollView(
          slivers: <Widget>[
            OurSliverAppBar(title: "Acceuil"),
            model.state == ViewState.Busy
                ? SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return SinglePublicationWidget(
                            publication: model.publications[index],
                            poster: model.publications[index]?.postedBy);
                      },
                      childCount: model.publications?.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }


}
