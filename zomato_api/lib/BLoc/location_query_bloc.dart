import 'dart:async';

import 'package:zomato_api/DataLayer/location.dart';
import 'package:zomato_api/DataLayer/zomato_client.dart';

import 'bloc.dart';

class LocationQueryBloc implements Bloc {
  final _controller = StreamController<List<Location>>.broadcast();
  final _client = ZomatoClient();
  Stream<List<Location>> get locationStream => _controller.stream;

  void submitQuery(String query)async{
    final results = await _client.fetchLocations(query);
    _controller.sink.add(results);
  }
  @override
  void dispose() {
    _controller.close();
  }
  
}