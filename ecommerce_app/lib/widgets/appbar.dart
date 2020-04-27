import 'package:flutter/material.dart';

class MyAppBar {
  static Widget getAppBar(BuildContext context, String state, String title) {
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
          Navigator.popAndPushNamed(context, '/');
        },
        child: Text(title),
      ),
      centerTitle: true,
      actions: icons,
    );
  }

 static List<Widget> getIcons(String state, BuildContext context) {
    switch (state) {
      case 'HOME':
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
      case 'LOGIN':
        return <Widget>[
          // new IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {},
          // ),
        ];
      // break;

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
