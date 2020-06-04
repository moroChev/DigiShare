import 'package:MyApp/WebService/NetworkImageController.dart';
import 'package:MyApp/entities/Agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgencyHeaderWidget extends StatefulWidget {
  final Agency agency;

  AgencyHeaderWidget({@required this.agency});

  @override
  _AgencyHeaderWidgetState createState() => _AgencyHeaderWidgetState();
}

class _AgencyHeaderWidgetState extends State<AgencyHeaderWidget> {
  @override
  Widget build(BuildContext context) {
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
                child: buildLogo(widget.agency.logo)
              ),
            ),
            //Farm name
            Text(widget.agency.name, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[500], fontSize: 22, fontWeight: FontWeight.bold)),
            //Farm description
            Text(widget.agency.address, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[400], fontSize: 16)),
          ],
        ),
      ),
    );
  }

  //method to load and construct agency's Logo
  Widget buildLogo(String logoUrl){
    return FutureBuilder(
      future: NetworkImageController.fetchImage(logoUrl),
      builder: ((BuildContext context, AsyncSnapshot<NetworkImage> image) {
        if (image.hasData) {
          return Image(image: image.data, alignment: Alignment.center, height: 100, width: 100);
        } else {
          return new Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}