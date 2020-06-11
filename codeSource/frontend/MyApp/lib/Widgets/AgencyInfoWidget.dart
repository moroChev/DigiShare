import 'package:MyApp/entities/Agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgencyInfoWidget extends StatefulWidget {
  final Agency agency;

  AgencyInfoWidget({this.agency});

  @override
  _AgencyInfoWidgetState createState() => _AgencyInfoWidgetState();
}

class _AgencyInfoWidgetState extends State<AgencyInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Material(
        elevation: 15.0,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        child: Wrap(children: [
          //Address Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.mapMarkerAlt, color: Colors.blueGrey[600]),
            title: Text(widget.agency.address, style: TextStyle(fontSize: 15, color: Colors.black,fontFamily: "Times")),
          ),
          Divider(height: 1, color: Colors.blueGrey[200],indent: 20,endIndent: 20,),

          //Working Calendar Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.clock, color: Colors.blueGrey[600]),
            title: Text('Open', style: TextStyle(fontSize: 15, color: Colors.black,fontFamily: "Times")),
          ),
          Divider(height: 1, color: Colors.blueGrey[200],indent: 20,endIndent: 20,),

          //Email Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.mailBulk, color: Colors.blueGrey[600]),
            title: Text(widget.agency.email, style: TextStyle(fontSize: 15, color: Colors.black,fontFamily: "Times")),
          ),
          Divider(height: 1, color: Colors.blueGrey[200],indent: 20,endIndent: 20,),

          //Telephone Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.phoneAlt, color: Colors.blueGrey[600]),
            title: Text(widget.agency.telephone, style: TextStyle(fontSize: 15, color: Colors.black,fontFamily: "Times")),
          ),
        ]),
      ),
    );
  }
}
