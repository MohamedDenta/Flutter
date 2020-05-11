import 'package:flutter/material.dart';
import 'package:layout_00/widgets/favorit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIMPLE LAYOUT'),
      ),
      // drawer: MyDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            MyCoverImg(),
            SecondRow(),
            ThirdRow(),
            FourthRow(),
          ],
        ),
      ),
    );
  }

  Widget MyCoverImg() {
    return Card(
      child: Image.asset(
        "assets/images/2017.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget SecondRow() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg,Switzerland',
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Favourit(),
          // Text('41'),
        ],
      ),
    );
  }

  Widget ThirdRow() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildButtonColumn(Colors.blue[500], Icons.call, 'CALL'),
          ),
          Expanded(
            child: _buildButtonColumn(Colors.blue[500], Icons.near_me, 'ROUTE'),
          ),
          Expanded(
            child: _buildButtonColumn(Colors.blue[500], Icons.share, 'SHARE'),
          ),
        ],
      ),
    );
  }

  Widget FourthRow() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true,
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
