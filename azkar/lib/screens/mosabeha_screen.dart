import 'dart:ui';

import 'package:flutter/material.dart';

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
          child: InkWell(
            borderRadius: BorderRadius.circular(35),
            onTap: (){
              setState(() {
                count++;
              });
            },
            child: ImageIcon(
              AssetImage(
                'assets/icons/finger.png',
              ),
              color: Colors.amber[900],
            size: 65,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            "$count",
            style: TextStyle(
              fontSize: 90,
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
