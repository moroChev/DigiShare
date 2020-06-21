import 'package:flutter/cupertino.dart';

import '../enum/viewstate.dart';
import '../services/network_image_service.dart';
import 'base_model.dart';

import '../../locator.dart';

class NetworkImageModel extends BaseModel {
  final NetworkImageService _imageService = locator<NetworkImageService>();

  NetworkImage _image;

  NetworkImage get image => _image;

  Future getImage(String imageUrl) async {
    setState(ViewState.Busy);
    this._image = await _imageService.getImage(imageUrl);
    setState(ViewState.Idle);
  }

}