import 'package:MyApp/core/models/agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:MyApp/ui/shared/decorated_logo.dart';

class AgencyHeader extends StatelessWidget {
  final Agency agency;
  AgencyHeader({@required this.agency});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
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
                child: DecoratedLogo(imageUrl: agency.logo),
              ),
            ),
            //Farm name
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Text(agency?.name, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: "Times")),
            ),
          ],
        ),
      ),
    );
  }
}