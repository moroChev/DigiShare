import 'package:MyApp/core/models/agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:MyApp/ui/shared/agency_header.dart';

class Map extends StatelessWidget {
  final List<Agency> agencies;
  final Position center;
  final Position userLocation;
  Map({@required this.agencies, @required this.center, this.userLocation});

  @override
  Widget build(BuildContext context) {
    // if user location is provided we make it the center of our map
    Position _center = (userLocation == null) ? center : userLocation;
    return FlutterMap(
      options: MapOptions(
        zoom: 7.0,
        center: LatLng(center.latitude, center.longitude),
        interactive: true,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(markers: _buildMarkersOnMap(context, agencies, userLocation)),
      ],
    );
  }

  //method to build the markers
  List<Marker> _buildMarkersOnMap(BuildContext context, List<Agency> agencies, Position userLocation) {
    //Markers List to return
    List<Marker> markers = List<Marker>();

    //Marker for the user location
   if(userLocation != null){
      var mainMarker = Marker(
        point: LatLng(userLocation.latitude, userLocation.longitude),
        builder: (context) => _buildCustomMarker(context: context),
      );
      markers.add(mainMarker);
    }

    //Markers for the agencies
    for (Agency agency in agencies) {
      var tmpMarker = Marker(
        point: LatLng(agency.location['lat'], agency.location['lng']),
        builder: (context) => _buildCustomMarker(context: context, infoModel: agency),
      );
      markers.add(tmpMarker);
    }
    return markers;
  }

  //method to build a single marker
  Widget _buildCustomMarker({BuildContext context, var infoModel}) {
    return Container(
      child: IconButton(
        icon: Icon((infoModel == null)
            ? FontAwesomeIcons.mapMarker
            : FontAwesomeIcons.mapMarkerAlt),
        color: Color(0xff6200ee),
        iconSize: 20.0,
        onPressed: (infoModel == null) ? (){} : () => _onMarkerPressed(context: context, model: infoModel),
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