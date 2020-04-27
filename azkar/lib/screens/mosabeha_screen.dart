import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getflutter/components/progress_bar/gf_progress_bar.dart';

class Mosabeha extends StatefulWidget {
  @override
  _MosabehaState createState() => _MosabehaState();
}

class _MosabehaState extends State<Mosabeha> {
  var count = 0;

  double op = 0.5;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: IconButton(
            //splashColor: Colors.orangeAccent,
            onPressed: () {
              setState(() {
                op = 0.0;
                count++;
                op = 0.5;
              });
            },
            icon: ImageIcon(
              AssetImage(
                'assets/icons/finger.png',
              ),
              color: Colors.amber[900],
              size: 500,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            "$count",
            style: TextStyle(
              fontSize: 100,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: MaterialButton(
            minWidth: 200,
            onPressed: () {
              setState(() {
                count = 0;
              });
            },
            child: Text(
              'تصفير العداد',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }
}
