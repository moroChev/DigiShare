import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io'; //HttpHeaders access to add the authorization header
import 'dart:convert';

class AgencyPage extends StatefulWidget {
  AgencyPage({Key key, this.title, this.agencyId, this.secureToken}) : super(key: key);

  final String title;
  final String agencyId;
  final String secureToken;

  @override
  _AgencyPageState createState() => _AgencyPageState();
}

class _AgencyPageState extends State<AgencyPage> {

  Map<String, dynamic> agency;

  @override
  void initState() {
    super.initState();
    loadData(widget.agencyId);
  }

  loadData(String agencyId) {
    String url = "http://192.168.43.107:3000/api/agencies/$agencyId";
    print("********************* loading data from $url *************************");
    http.get(url, headers: {HttpHeaders.authorizationHeader: "${widget.secureToken}"})
        .then((resp) {
      setState(() {
        this.agency = jsonDecode(resp.body)['agency'];
        print("************************ result ${this.agency}");
      });
    }).catchError((err) {
      print("********************** $err ************************");
    });
  }

  @override
  Widget build(BuildContext context) {
    return (agency == null) ? Container(color: Colors.white, child: Center(child: CircularProgressIndicator()),) : Scaffold(

      //App background
      body: Container(
        color: Colors.blueGrey[50],
        child: ListView(
            children: <Widget>[
              //Header Section
              _buildHeader(),

              //Body Section
              Column(
                children: [
                  //Agency Info Container
                  _buildAgencyInfoContainer(),

                  //Map Label
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Our Subsidiaries', style: TextStyle(fontSize: 18, color: Colors.grey[500])),
                    ),
                  ),

                  //Map Container
                  _buildMapContainer(),

                  //Employees Section Label
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 30.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Our Employees', style: TextStyle(fontSize: 18, color: Colors.grey[500])),
                    ),
                  ),

                  //Employees Container
                  _buildEmployeesContainer(),

                  //Copyright Section
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
                    child: Text("Copyright  © 2020"),
                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }

  // method to build the main header Section for the page
  Widget _buildHeader(){
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Farm logo
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                elevation: 15.0,
                color: Colors.white,
                child: Image.network(agency['logo'], alignment: Alignment.center, height: 100, width: 100),
              ),
            ),
            //Farm name
            Text(agency['name'], textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[500], fontSize: 22, fontWeight: FontWeight.bold)),
            //Farm description
            Text(agency['address'], textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[400], fontSize: 16)),
          ],
        ),
      ),
    );
  }

  // method to build the agency info Section .. (under the header)
  Widget _buildAgencyInfoContainer(){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
      child: Material(
        elevation: 15.0,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
        child: Wrap(children: [
          //Address Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.mapMarkerAlt, color: Colors.blueGrey[600],),
            title: Text(agency['address'], style: TextStyle(fontSize: 15, color: Colors.blueGrey[600])),
          ),
          Divider(height: 1, color: Colors.blueGrey[200],),

          //Working Calendar Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.clock, color: Colors.blueGrey[600],),
            title: Text('Open', style: TextStyle(fontSize: 15, color: Colors.blueGrey[600],),),
          ),
          Divider(height: 1, color: Colors.blueGrey[200],),

          //Email Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.mailBulk, color: Colors.blueGrey[600],),
            title: Text(agency['email'], style: TextStyle(fontSize: 15, color: Colors.blueGrey[600],),),
          ),
          Divider(height: 1, color: Colors.blueGrey[200],),

          //Telephone Tile
          ListTile(
            leading: Icon(FontAwesomeIcons.phoneAlt, color: Colors.blueGrey[600],),
            title: Text(agency['telephone'], style: TextStyle(fontSize: 15, color: Colors.blueGrey[600],),),
          ),
        ]),
      ),
    );
  }

  // method to build the map container to display the agency subsidiaries
  Widget _buildMapContainer(){
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
                center: LatLng((agency['location'] as Map<String, dynamic>)['lat'], (agency['location'] as Map<String, dynamic>)['lng']),
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

  // method to build agency subsidiaries markers on the map
  List<Marker> _buildMarkersOnMap(){

    //Markers List to return
    List<Marker> markers = List<Marker>();

    //Marker for the agency
    var mainMarker = Marker(
      point: LatLng(
          (agency['location'] as Map<String, dynamic>)['lat'],
          (agency['location'] as Map<String, dynamic>)['lng']
      ),
      /*
      builder: (context) => GestureDetector(
          onTap: () {
            setState(() {
              infoWindowVisible = !infoWindowVisible;
            });
          },
          child: _buildCustomMarker(main: true, infoModel: agency),
      )
       */
      builder: (context) => _buildCustomMarker(main: true, infoModel: agency),
    );

    markers.add(mainMarker);

    //Markers for the subsidiaries
    for(Map<String,dynamic> subsidiary in agency['Subsidiaries']) {
      var tmpMarker = Marker(
        point: LatLng(
            (subsidiary['location'] as Map<String, dynamic>)['lat'],
            (subsidiary['location'] as Map<String, dynamic>)['lng']
        ),
        /*
        builder: (context) => GestureDetector(
          onTap: () {
            setState(() {
              infoWindowVisible = !infoWindowVisible;
            });
          },
          child: _buildCustomMarker(main: false, infoModel: subsidiary),
        )
         */
        builder: (context) => _buildCustomMarker(main: false, infoModel: subsidiary),
      );

      markers.add(tmpMarker);
    }

    return markers;
  }

  // method to build a single marker .. here main is a boolean that refers to the type of the marker (main marker or a marker of a subsidiary)
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




/*

  var infoWindowVisible = false;
  Stack _buildCustomMarker({bool main, var infoModel}) {
    return Stack(
      children: <Widget>[
        popup(infoModel: infoModel),
        marker(main: main, infoModel: infoModel)
      ],
    );
  }
  Opacity popup({var infoModel}) {
    return Opacity(
      opacity: infoWindowVisible ? 1.0 : 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 400.0,
        height: 400.0,
        color: Colors.white,
        /*
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/ic_info_window.png"),
                fit: BoxFit.cover)),
         */
        child: customPopup(infoModel: infoModel),
      ),
    );
  }
  Opacity marker({bool main, var infoModel}) {
    return Opacity(
      child: Container(
        child: IconButton(
          icon: Icon((main)? FontAwesomeIcons.mapMarker : FontAwesomeIcons.mapMarkerAlt),
          color: Color(0xff6200ee),
          iconSize: 20.0,
          //onPressed: (){},
          //onPressed: () => _onMarkerPressed(model: infoModel),
        ),
      ),
      opacity: infoWindowVisible ? 0.0 : 1.0,
    );
  }

  Widget customPopup({var infoModel}){
    return Container(
      //padding: EdgeInsets.all(5.0),
      width: 400.0,
      height: 400.0,
      child: Text(infoModel['name'],style: TextStyle(color: Colors.black),)
    );
  }

*/

  // method invoked when a marker is pressed
  //this method will be modified soon
  void _onMarkerPressed({var model}) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          //Bottom Sheet container
          child: ListView(
            children: <Widget>[
              //Header Section
              Container(
                color: Color(0xff6200ee),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        model['name'],
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        model['address'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Body Section
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    //Button Section in the top of the body
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //CALL Button
                        MaterialButton(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.phone,
                                color: Color(0xff6200ee),
                              ),
                              Text(
                                'CALL',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff6200ee),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            print('CALL Pressed');
                          },
                        ),

                        //Website Button
                        MaterialButton(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.globe,
                                color: Color(0xff6200ee),
                              ),
                              Text(
                                'WEBSITE',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff6200ee),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            print('WEBSITE Pressed');
                          },
                        ),

                        //Share button
                        MaterialButton(
                          child: Column(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.share,
                                color: Color(0xff6200ee),
                              ),
                              Text(
                                'SHARE',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff6200ee),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            print('SHARE Pressed');
                          },
                        ),
                      ],
                    ),

                    //List items in the body
                    Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Color(0xff6200ee),
                          ),
                          title: Text(
                            model['address'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff6200ee),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.clock,
                            color: Color(0xff6200ee),
                          ),
                          title: Text(
                            'Open',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff6200ee),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.link,
                            color: Color(0xff6200ee),
                          ),
                          title: Text(
                            model['email'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff6200ee),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            FontAwesomeIcons.phoneAlt,
                            color: Color(0xff6200ee),
                          ),
                          title: Text(
                            model['telephone'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff6200ee),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // method to build the entire employees section in the bottom of the page
  //it's a scroller(SingleChildScrollView) inside a fixed size widget(AspectRatio)
  Widget _buildEmployeesContainer(){
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10.0),
      child: (agency['employees'].length == 0)? Text('No employees yet', style: TextStyle(fontSize: 18, color: Colors.grey[500])) : AspectRatio(
        // 59 here refers to the approximate height of a single ListTile (employee)
        // So (agency['employees'].length * 59 is the approximate height of our Wrap widget ...
        // I think I made it clear enough here
        aspectRatio: (MediaQuery.of(context).size.width/(agency['employees'].length * 59) < 3/4)? 3/4 : MediaQuery.of(context).size.width/(agency['employees'].length * 59),
        child: Material(
          elevation: 15.0,
          color: Color(0xff535880),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 5,
              children: _buildCustomEmployees(),
            ),
          ),
        ),
      ),
    );
  }

  // method to build the content of the scroller .. a list of employee sections
  List<Widget> _buildCustomEmployees(){
    // Widgets to return
    List<Widget> employees = List<Widget>();

    for(Map<String,dynamic> emp in agency['employees']){
      //Single employee section
      Widget employee = Column(children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.transparent,
            backgroundImage: (emp['imageEmployee'] == null) ? FontAwesomeIcons.user : NetworkImage(emp['imageEmployee']),
          ),
          title: Text(emp['firstName'].toString() + " " + emp['lastName'].toString()),
          onTap: () {},
        ),
        Divider(height: 1, color: Colors.blueGrey[200]),
      ]);

      employees.add(employee);
    }

    return employees;
  }

}
