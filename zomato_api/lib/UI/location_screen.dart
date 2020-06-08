import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zomato_api/BLoc/bloc_provider.dart';
import 'package:zomato_api/BLoc/location_bloc.dart';
import 'package:zomato_api/BLoc/location_query_bloc.dart';
import 'package:zomato_api/DataLayer/location.dart';
import 'package:zomato_api/UI/welcome_screen.dart';

class LocationScreen extends StatelessWidget {
  final bool isFullScreenDialog;

  const LocationScreen({Key key, this.isFullScreenDialog}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bloc = LocationQueryBloc();

    return BlocProvider<LocationQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Where do you want to eat?',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10),
                child: Text(
                  'logout',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
              onTap: () {
                signout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a location'),
                onChanged: (query) {
                  bloc.submitQuery(query);
                },
              ),
            ),
            Expanded(
              child: _buildResults(bloc),
            )
          ],
        ),
      ),
    );
  }

  _buildResults(LocationQueryBloc bloc) {
    return StreamBuilder<List<Location>>(
      stream: bloc.locationStream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(
            child: Text('Enter a location'),
          );
        }

        if (results.isEmpty) {
          return Center(
            child: Text('No Results'),
          );
        }

        return _buildSearchResults(results);
      },
    );
  }

  Widget _buildSearchResults(List<Location> results) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final location = results[index];
        return ListTile(
          title: Text(location.title),
          onTap: () {
            final locationBloc = BlocProvider.of<LocationBloc>(context);
            locationBloc.selectLocation(location);

            if (isFullScreenDialog) {
              Navigator.of(context).pop();
            }
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: results.length,
    );
  }

  signout() async {
    var user = FirebaseAuth.instance.currentUser();
    if (user != null) {
      await FirebaseAuth.instance.signOut().catchError((onError) {
        print(onError);
      });
    }
  }
}
