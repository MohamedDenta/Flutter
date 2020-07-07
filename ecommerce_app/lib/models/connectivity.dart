import 'package:connectivity/connectivity.dart';
import 'package:ecommerce_app/enums/connectivity_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConnectivityService with ChangeNotifier {
  static ConnectivityStatus _status;
  ConnectivityStatus get status => _status;

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _status = _getStatusFromResult(result);
      notifyListeners();
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
        break;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
        break;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
        break;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
