import 'package:flutter/material.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/shared/emp_list_tile/employee_list_tile.dart';
import 'package:MyApp/ui/shared/floatingButton.dart';
import 'package:MyApp/ui/shared/sliverAppBar.dart';
import 'package:MyApp/core/viewmodels/publication_models/post_single_model.dart';

class LikesWidget extends StatelessWidget {
  final String publicationId;

  LikesWidget({@required this.publicationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(),
      backgroundColor: Color(0xFFF5F5F8),
      body: BaseView<SinglePostModel>(
        onModelReady: (model) => model.getLikes(publicationId),
        builder: (context, model, child) => 
        model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: <Widget>[
                  OurSliverAppBar(title: "Likes ${model.employeesWhoLiked.length}"),
                  model.state == ViewState.Busy
                      ? SliverFillRemaining( child: Center( child: CircularProgressIndicator()))
                      : model.employeesWhoLiked.length == 0
                          ? SliverFillRemaining(child: Center(child: Text("Aucune Réaction",textAlign: TextAlign.center,)))
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return EmployeeListTile(
                                      employee: model.employeesWhoLiked[index],
                                      subtitle: model.employeesWhoLiked[index].agency.name
                                      );
                                },
                                childCount: model.employeesWhoLiked.length,
                              ),
                            ),
                ],
              ),
      ),
    );
  }
}
