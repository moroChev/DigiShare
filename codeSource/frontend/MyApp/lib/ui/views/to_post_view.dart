import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/ui/widgets/to_post_widgets/to_post_box/tp_post_box.dart';
import 'package:MyApp/core/models/employee.dart';
import 'package:MyApp/core/models/publication.dart';
import 'package:MyApp/core/viewmodels/to_post_model.dart';
import 'package:MyApp/ui/shared/CustomAppBar.dart';
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
      onModelReady: (model) => model.initData(post, user),
      builder: (context, model, child) => model.state == ViewState.Idle
          ? Scaffold(
              appBar: CustomAppBar(
                height: 60,
              ),
              body: PublicationBox(),
              bottomSheet: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CreateBtn(),
                    SizedBox(
                      width: 10,
                    ),
                    SelectImageBtn(),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
