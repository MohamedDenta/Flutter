import 'package:flutter/material.dart';

import 'menu_items.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
      children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("zwert1436@gmail.com"),
            accountName: Text("Mohamed Abdulfattah"),
            // currentAccountPicture: Image.asset("assets/images/my2.jpg"),
          ),
          Divider(
            color: Colors.white,
          ),
          MyMenuItems()
      ],
    ),
        ));
  }
}
