import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Leaflet Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var mainLocation = [31.923482, -4.437468];
  var _latlng = [
    [31.924199, -4.436543],
    [31.928413, -4.429545],
  ];
  var _agencies = [
    {
      'name': 'JP & CO',
      'desc': 'Tracking society',
      'phone': '+212 641 712 314',
      'mail': 'echcharaymohamed@gmail.com',
      'lat': 31.924199,
      'lng': -4.436543,
    },
    {
      'name': 'SijilMassa High School',
      'desc': '800.123.32.455 Errachidia N13 ...',
      'phone': '+212 624 726 868',
      'mail': 'https://www.luv2code.com/be-happy',
      'lat': 31.928413,
      'lng': -4.429545,
    },
  ];
  var agency = {
    'name': 'JP & CO',
    'desc': 'Tracking society',
    'phone': '+212 641 712 314',
    'mail': 'echcharaymohamed@gmail.com',
    'lat': 31.923482,
    'lng': -4.437468,
    'img_url':
        'http://www.jp.co.ma/wp-content/uploads/2016/11/logo_JP_CO_VECTOR1.png',
  };
  var employees = [
    {
      'firstName': 'Mohamed',
      'lastName': 'Ech-charay',
      'position': 'Manager',
      'email': 'echcharaymohamed@gmail.com',
    },
    {
      'firstName': 'Mohcine',
      'lastName': 'Rouessi',
      'position': 'Manager',
      'email': 'mohcinerouessi@gmail.com',
    },
    {
      'firstName': 'Yassine',
      'lastName': 'Ech-charay',
      'position': 'Director',
      'email': 'echcharayyassine@gmail.com',
    },
    {
      'firstName': 'Souhaila',
      'lastName': 'Ech-charay',
      'position': 'Developer',
      'email': 'echcharaySouhaila@gmail.com',
    },
    {
      'firstName': 'Abdo',
      'lastName': 'Ismaili',
      'position': 'Developer',
      'email': 'luv2code@gmail.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text(widget.title),
      ),*/

      //App background
      body: Container(
        color: Colors.blueGrey[50],
        child: ListView(
          children: <Widget>[
            //Header Section
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: AspectRatio(
                aspectRatio: 5 / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Farm logo
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue[900], width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Image.network(agency['img_url'],
                          alignment: Alignment.center, height: 100, width: 100),
                    ),
                    //Farm name
                    Text(agency['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    //Farm description
                    Text(agency['desc'],
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 16)),
                  ],
                ),
              ),
            ),

            //Body Section
            Column(
              children: [
                //Farm Infos Container
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff535880),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Wrap(children: [
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Colors.blueGrey[200],
                        ),
                        title: Text(
                          agency['desc'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey[200],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.clock,
                          color: Colors.blueGrey[200],
                        ),
                        title: Text(
                          'Open',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey[200],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.link,
                          color: Colors.blueGrey[200],
                        ),
                        title: Text(
                          agency['mail'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey[200],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.phoneAlt,
                          color: Colors.blueGrey[200],
                        ),
                        title: Text(
                          agency['phone'],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueGrey[200],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),

                //Map Container
                Padding(
                  padding: EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Center(

                      child: FlutterMap(
                        options: MapOptions(
                          zoom: 13.0,
                          center: LatLng(mainLocation[0], mainLocation[1]),
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayerOptions(
                            markers: [
                              Marker(
                                point: LatLng(
                                    _agencies[0]['lat'], _agencies[0]['lng']),
                                builder: (context) => Container(
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                                    color: Color(0xff6200ee),
                                    iconSize: 20.0,
                                    onPressed: () =>
                                        _onMarkerPressed(model: _agencies[0]),
                                  ),
                                ),
                              ),
                              Marker(
                                point: LatLng(
                                    _agencies[1]['lat'], _agencies[1]['lng']),
                                builder: (context) => Container(
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.mapMarker),
                                    color: Color(0xff6200ee),
                                    iconSize: 20.0,
                                    onPressed: () =>
                                        _onMarkerPressed(model: _agencies[1]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Personnel Container
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff535880),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Wrap(
                      spacing: 5,
                      children: <Widget>[
                        ...(employees as List<Map<String, Object>>).map((emp) {
                          return ListTile(
                            leading: Icon(FontAwesomeIcons.user),
                            title: Text(emp['firstName'].toString() +
                                emp['lastName'].toString()),
                            onTap: () {},
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

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
                        model['desc'],
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
                            model['desc'],
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
                            model['mail'],
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
                            model['phone'],
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
}
