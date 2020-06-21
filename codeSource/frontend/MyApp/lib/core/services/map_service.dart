import 'package:MyApp/core/models/agency.dart';
import 'package:MyApp/core/repositories/agency_repo.dart';
import 'package:geolocator/geolocator.dart';

import '../../locator.dart';

class MapService {
  final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;
  final AgencyRepo _api = locator<AgencyRepo>();

  Future<Position> fetchCurrentLocation() async {
    var result;
    try {
      result = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    }catch(e){
      result = null;
    }
    var hasData = result != null;
    if (hasData)
      print('${this.runtimeType.toString()}:---> User\'s current location fetched successfully');
    else
      print('${this.runtimeType.toString()}:---> Failed to load user\'s current location');
    return result;
  }

  Future<bool> checkPermission() async {
    var geolocationStatus;
    try{
      geolocationStatus = await _geolocator.isLocationServiceEnabled();
    }catch(e){
      geolocationStatus = false;
    }
    return geolocationStatus;
  }

  Future<List<Agency>> getAllAgencies() async {
    var fetchedAgencies = await _api.fetchAllAgencies();
    var hasData = fetchedAgencies != null;
    if(hasData){
      print('${this.runtimeType.toString()}:---> agencies List fetched successfully');
    }
    else
      print('${this.runtimeType.toString()}:---> Failed to load Agencies List');
    return fetchedAgencies;
  }
}