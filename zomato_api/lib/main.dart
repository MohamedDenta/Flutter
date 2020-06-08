import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zomato_api/BLoc/bloc_provider.dart';
import 'package:zomato_api/BLoc/favorite_bloc.dart';
import 'package:zomato_api/BLoc/location_bloc.dart';
import 'package:zomato_api/UI/welcome_screen.dart';

import 'DataLayer/auth/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      bloc: LocationBloc(),
      child: BlocProvider<FavoriteBloc>(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Zomato',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: WelcomeScreen(),
        ),
      ),
    );
  }
}
