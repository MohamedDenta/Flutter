import 'dart:async';

import 'package:zomato_api/DataLayer/location.dart';

import 'bloc.dart';

class LocationBloc implements Bloc {
  Location _location;
  Location get selectedLocation => _location;

  final _locationController = StreamController<Location>.broadcast();
  Stream<Location> get locationStream => _locationController.stream;

  void selectLocation(Location location){
    _location = location;
    _locationController.sink.add(location);
  }
  @override
  void dispose() {
    _locationController.close();
  }
}
