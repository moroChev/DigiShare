import 'dart:async';
import 'package:flutter/cupertino.dart';

import '../repositories/network_image_repo.dart';
import '../../locator.dart';

class NetworkImageService {
  NetworkImageRepo _api = locator<NetworkImageRepo>();

  Future<NetworkImage> getImage(String imageUrl) async {
    var fetchedImage = await _api.fetchImage(imageUrl);
    var hasData = fetchedImage != null;
    if (hasData)
      print('${this.runtimeType.toString()}:---> NetworkImage fetched successfully');
    else
      print('${this.runtimeType.toString()}:---> Failed to load NetworkImage');
    return fetchedImage;
  }
}