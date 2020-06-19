import 'package:MyApp/Widgets/CustumAppBar.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/viewmodels/map_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';
import 'package:MyApp/ui/shared/map.dart';
import 'package:MyApp/ui/shared/divider_with_title.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MapModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: CustomAppBar.getAppBar(context),

        //App background
        backgroundColor: Colors.blueGrey[50],
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  DividerWithTitle(title: "DigiShare Map"),
                  Expanded(
                      child: Map(agencies: model.agencies, center: model.center, userLocation: model.currentLocation),
                  ),
                  DividerWithTitle(title: ""),
                ],
        ),
      ),
    );
  }
}
