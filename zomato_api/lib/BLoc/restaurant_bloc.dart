import 'dart:async';

import 'package:zomato_api/DataLayer/location.dart';
import 'package:zomato_api/DataLayer/restaurant.dart';
import 'package:zomato_api/DataLayer/zomato_client.dart';

import 'bloc.dart';

class RestaurantBloc implements Bloc {
  final _controller = StreamController<List<Restaurant>>();
  final _client = ZomatoClient();
  final Location location;

  Stream<List<Restaurant>> get stream => _controller.stream;

  RestaurantBloc(this.location);

  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
