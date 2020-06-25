import 'package:flutter/widgets.dart';
import '../enum/viewstate.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  bool _mounted = true;

  ViewState get state => _state;
  bool get mounted => _mounted;

  void setState(ViewState viewState) {
    if(mounted){
      _state = viewState;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }

  
}