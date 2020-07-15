import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar {
  static BuildContext myContext;
  static Widget getAppBar(
      BuildContext context, AppBarStatus state, String title) {
    myContext = context;
    var icons = getIcons(state, context);
    //  <Widget>[
    //     new IconButton(
    //       icon: Icon(Icons.search),
    //       onPressed: () {},
    //     ),
    //     new IconButton(
    //       icon: Icon(Icons.shopping_cart),
    //       onPressed: () {
    //         Navigator.pushNamed(context,'/cart');
    //       },
    //     ),
    //   ]
    // : <Widget>[
    //     new IconButton(
    //       icon: Icon(Icons.search),
    //       onPressed: () {},
    //     ),
    //   ];

    return AppBar(
      title: InkWell(
        onTap: () {
          //Navigator.popAndPushNamed(context, '/');
        },
        child: Text(title),
      ),
      centerTitle: true,
      actions: icons,
    );
  }

  static List<Widget> getIcons(AppBarStatus state, BuildContext context) {
    switch (state) {
      case AppBarStatus.Home:
        return <Widget>[
          new IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ];
      // break;
      case AppBarStatus.Login:
        return <Widget>[
          // new IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
        ];
      // break;
      case AppBarStatus.Account:
        return <Widget>[
          new IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              final bloc =
                  Provider.of<FirebaseProvider>(context, listen: false);
              bloc.logout();
              Navigator.of(context).popAndPushNamed('/login');
            },
          ),
        ];
      case AppBarStatus.Your:
        return <Widget>[];
      case AppBarStatus.AdressBook:
        return <Widget>[];
      case AppBarStatus.CountryLang:
        return <Widget>[
          new IconButton(icon: Icon(Icons.done_all), onPressed: () {})
        ];
      default:
        return <Widget>[
          new IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ];
    }
  }
}
