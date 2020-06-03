import 'package:MyApp/WebService/NetworkImageController.dart';
import 'package:MyApp/Widgets/AgencyHeaderWidget.dart';

import '../Screens/AgencyScreen.dart';
import '../entities/Agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapContainerWidget extends StatefulWidget {
  final Agency agency;
  final List<Agency> subsidiaries;

  MapContainerWidget({this.agency, this.subsidiaries});

  @override
  _MapContainerWidgetState createState() => _MapContainerWidgetState();
}


class _MapContainerWidgetState extends State<MapContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Material(
        elevation: 15.0,
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Center(
            child: FlutterMap(
              options: MapOptions(
                zoom: 14.0,
                center: LatLng(widget.agency.location['lat'], widget.agency.location['lng']),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(markers: _buildMarkersOnMap()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //method to build the markers
  List<Marker> _buildMarkersOnMap(){
    //Markers List to return
    List<Marker> markers = List<Marker>();

    //Marker for the agency
    var mainMarker = Marker(
      point: LatLng(widget.agency.location['lat'], widget.agency.location['lng']),
      builder: (context) => _buildCustomMarker(main: true, infoModel: widget.agency),
    );
    markers.add(mainMarker);

    //Markers for the subsidiaries
    for(Agency subsidiary in widget.subsidiaries) {
      var tmpMarker = Marker(
        point: LatLng(subsidiary.location['lat'], subsidiary.location['lng']),
        builder: (context) => _buildCustomMarker(main: false, infoModel: subsidiary),
      );
      markers.add(tmpMarker);
    }
    return markers;
  }

  //method to build a single marker
  Widget _buildCustomMarker({bool main, var infoModel}){
    return Container(
      child: IconButton(
        icon: Icon((main)? FontAwesomeIcons.mapMarker : FontAwesomeIcons.mapMarkerAlt),
        color: Color(0xff6200ee),
        iconSize: 20.0,
        onPressed: () => _onMarkerPressed(model: infoModel),
      ),
    );
  }

  //method invoked when a marker is pressed
  void _onMarkerPressed({var model}) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => AgencyScreen(agencyId: model.id)));
          },
          child: AgencyHeaderWidget(agency: model),
        );
      },
    );
  }
}
