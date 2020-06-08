import 'package:flutter/material.dart';
import 'package:zomato_api/BLoc/bloc_provider.dart';
import 'package:zomato_api/BLoc/favorite_bloc.dart';
import 'package:zomato_api/DataLayer/restaurant.dart';

import 'widgets/restaurant_tile.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: bloc.favoritesStream,
        initialData: bloc.favorites,
        builder: (context, snaphot) {
          List<Restaurant> favorites =
              (snaphot.connectionState == ConnectionState.waiting)
                  ? bloc.favorites
                  : snaphot.data;
          if (favorites == null || favorites.isEmpty) {
            return Center(
              child: Text('No Favorites'),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return RestaurantTile(restaurant: restaurant);
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: favorites.length,
          );
        },
      ),
    );
  }
}
