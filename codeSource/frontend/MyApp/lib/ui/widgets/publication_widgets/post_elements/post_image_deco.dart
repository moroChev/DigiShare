import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../views/base_view.dart';
import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/viewmodels/network_image_model.dart';

class PostImage extends StatelessWidget {

 final String imageUrl;

 PostImage({@required this.imageUrl});

    @override
  Widget build(BuildContext context) {
    return BaseView<NetworkImageModel>(
      onModelReady: (model) => model.getImage(imageUrl),
      builder: (context, model, child) => model.state == ViewState.Busy
          ? Container(
              height: 170.0,
              width: 280.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              height: 170.0,
              width: 280.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: model.image,
                  ),
              ),
            )
    );
  }
}