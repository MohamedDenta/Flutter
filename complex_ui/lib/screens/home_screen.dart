import '../widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.black),
      Icon(Icons.star, color: Colors.black),
    ],
  );
  static final ratings = Container(
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        stars,
        Text(
          '170 Reviews',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontFamily: 'Roboto',
            letterSpacing: 0.5,
            fontSize: 20,
          ),
        ),
      ],
    ),
  );

  static var descTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontFamily: 'Robot',
    letterSpacing: 0.5,
    fontSize: 18,
    height: 2,
  );

  static final iconList = DefaultTextStyle.merge(
    style: descTextStyle,
    child: Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                Icons.kitchen,
                color: Colors.green[500],
              ),
              Text('PREP:'),
              Text('25 min'),
              Column(
                children: <Widget>[
                  Icon(Icons.timer, color: Colors.green[500]),
                  Text('COOK:'),
                  Text('1 hr'),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.timer, color: Colors.green[500]),
                  Text('FEEDS:'),
                  Text('4-6'),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
  static final titleText = Card(
    elevation: 2,
    margin: EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'To create a row or column in Flutter',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ),
  );
  static final subTitle = Card(
    elevation: 2,
    margin: EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
          'To create a row or column in Flutter,\n you add a list of children widgets to a Row or Column widget. \nIn turn, each child can itself \nbe a row or column, and so on.\nThe following example shows how it is possible to nest rows or columns inside of rows or columns'),
    ),
  );

  static final leftColumn = Container(
    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
    child: Column(
      children: [
        titleText,
        subTitle,
        ratings,
        iconList,
      ],
    ),
  );
  static final mainImage = Image.asset('assets/images/2017.jpg');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الله أكبر'),
      ),
      drawer: MyDrawer(),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
        height: 600,
        child: Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 440,
                child: leftColumn,
              ),
              Expanded(child: mainImage),
            ],
          ),
        ),
      ),
    );
  }
}
