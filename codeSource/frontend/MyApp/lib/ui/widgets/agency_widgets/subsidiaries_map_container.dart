import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/viewmodels/agency_model.dart';
import 'package:MyApp/ui/views/base_view.dart';

import '../../../core/models/agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'agency_header.dart';

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
                  : FlutterMap(
                      options: MapOptions(
                        zoom: 14.0,
                        center: LatLng(
                            agency.location['lat'], agency.location['lng']),
                      ),
                      layers: [
                        TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayerOptions(markers: _buildMarkersOnMap(context, model.subsidiaries)),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  //method to build the markers
  List<Marker> _buildMarkersOnMap(BuildContext context, List<Agency> subsidiaries) {
    //Markers List to return
    List<Marker> markers = List<Marker>();

    //Marker for the agency
    var mainMarker = Marker(
      point: LatLng(agency.location['lat'], agency.location['lng']),
      builder: (context) =>
          _buildCustomMarker(context: context, main: true, infoModel: agency),
    );
    markers.add(mainMarker);

    //Markers for the subsidiaries
    for (Agency subsidiary in subsidiaries) {
      var tmpMarker = Marker(
        point: LatLng(subsidiary.location['lat'], subsidiary.location['lng']),
        builder: (context) => _buildCustomMarker(
            context: context, main: false, infoModel: subsidiary),
      );
      markers.add(tmpMarker);
    }
    return markers;
  }

  //method to build a single marker
  Widget _buildCustomMarker({BuildContext context, bool main, var infoModel}) {
    return Container(
      child: IconButton(
        icon: Icon((main)
            ? FontAwesomeIcons.mapMarker
            : FontAwesomeIcons.mapMarkerAlt),
        color: Color(0xff6200ee),
        iconSize: 20.0,
        onPressed: main ? (){} : () => _onMarkerPressed(context: context, model: infoModel),
      ),
    );
  }

  //method invoked when a marker is pressed
  void _onMarkerPressed({BuildContext context, var model}) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return MaterialButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/Agency', ModalRoute.withName("/Home"),
                arguments: model.id);
          },
          child: AgencyHeader(agency: model),
        );
      },
    );
  }
}
