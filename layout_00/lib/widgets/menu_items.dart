import 'package:flutter/material.dart';

class MyMenuItems extends StatelessWidget {
  const MyMenuItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text('Home Screen'),
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ),
      ],
    );
  }
}
