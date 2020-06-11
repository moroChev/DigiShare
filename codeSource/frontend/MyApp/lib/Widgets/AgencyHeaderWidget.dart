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
      padding: const EdgeInsets.only(top: 60),
      child: AspectRatio(
        aspectRatio: 5 / 4,
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
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Text(widget.agency?.name, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: "Times")),
            ),
            //Farm description
           /*  Padding(
              padding: const EdgeInsets.only(top:10,bottom:10),
              child: Text(widget.agency?.address, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16,fontFamily: "Times")),
            ), */
          ],
        ),
      ),
    );
  }

  //method to load and construct agency's Logo
Widget buildLogo(String logoUrl){
    print("the logo to fetch is .... $logoUrl");
    return FutureBuilder(
      future: NetworkImageController.fetchImage(logoUrl),
      builder: ((BuildContext context, AsyncSnapshot<NetworkImage> image) {
        if (image.hasData) {
          return decoratedLogo(image.data);
          //Image(image: image.data, alignment: Alignment.center, height: 170, width: 160);
        } else {
          return new Center(child: CircularProgressIndicator());
        }
      }),
    );
  }



  Widget decoratedLogo(NetworkImage image){
    return Container(
        height: 170.0,
        width: 160.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
            border: Border.all(color: Colors.white, width: 6.0)),
      );
  }




}