import 'package:MyApp/core/enum/viewstate.dart';
import 'package:MyApp/core/models/agency.dart';
import 'package:MyApp/core/services/map_service.dart';
import 'package:geolocator/geolocator.dart';

import '../../locator.dart';
import 'base_model.dart';

class MapModel extends BaseModel {
  final MapService _mapService = locator<MapService>();

  Position _currentLocation;
  bool _isLocationServiceEnabled;
  List<Agency> _agencies;
  Position _center;

  Position get currentLocation => _currentLocation;
  bool get isLocationServiceEnabled => _isLocationServiceEnabled;
  List<Agency> get agencies => _agencies;
  Position get center => _center;

  Future getCurrentLocation() async {
    this._isLocationServiceEnabled = await _mapService.checkPermission();
    if(_isLocationServiceEnabled)
      this._currentLocation = await _mapService.fetchCurrentLocation();
    setState(ViewState.Idle);
  }

  Future init() async {
    setState(ViewState.Busy);
    this._agencies = await _mapService.getAllAgencies();
    calculateCenter();
    // no need to wait until current location get fetched to start building the map
    getCurrentLocation();
    setState(ViewState.Idle);
  }

  void calculateCenter(){
    double lat = .0;
    double lng = .0;
    var _length = _agencies.length;
    for(Agency agency in _agencies){
      lat += agency.location['lat'];
      lng += agency.location['lng'];
    }
    this._center = Position(latitude: lat/_length, longitude: lng/_length);
  }

}