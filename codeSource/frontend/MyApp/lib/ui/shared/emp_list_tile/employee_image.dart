import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/viewmodels/network_image_model.dart';
import 'package:MyApp/ui/views/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeImage extends StatelessWidget {
  
  final String imageUrl;
  EmployeeImage({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BaseView<NetworkImageModel>(
      onModelReady: (model) => model.getImage(imageUrl),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Container(
              height: 80.0,
              width: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
             //   border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: 80.0,
              width: 60.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: model.image == null
                        ? AssetImage("asset/img/person.png")
                        : model.image,
                  ),
                  border: Border.all(color: Colors.white, width: 1.0)),
            ),
    );
  }
}
