import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/viewmodels/agency_model.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/models/agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/map.dart';

class MapContainerWidget extends StatelessWidget {
  final Agency agency;
  MapContainerWidget({this.agency});

  @override
  Widget build(BuildContext context) {
    return BaseView<AgencyModel>(
      onModelReady: (model) => model.getAgencySubsidiaries(agency.id),
      builder: (context, model, child) => Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Material(
          elevation: 15.0,
          color: Colors.white,
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: Center(
              child: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  : Map(agencies: [agency], center: Position(latitude: agency.location['lat'], longitude: agency.location['lng'])),
            ),
          ),
        ),
      ),
    );
  }
}
