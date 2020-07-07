import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class YourScreen extends StatefulWidget {
  @override
  _YourScreenState createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Your, ''),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Yours',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text('Browse what you want from the menu below'),
          ),
          Expanded(
            child: getGrid(),
          ),
        ],
      ),
    );
  }

  var list = [
    Card(
      child: ListTile(
        title: Icon(Icons.hearing),
        subtitle: Text('Recommendations'),
        onTap: (){

        },
      ),
    ),
    Card(
      child: ListTile(
        title: Icon(Icons.shopping_cart),
        subtitle: Text('Buy it Again'),
        onTap: (){

        },
      ),
    ),
    Card(
      child: ListTile(
        title: Icon(Icons.money_off),
        subtitle: Text('Price Drop'),
        onTap: (){

        },
      ),
    ),
    Card(
      child: ListTile(
        title: Icon(Icons.history),
        subtitle: Text('Browse History'),
        onTap: (){
          
        },
      ),
    ),
  ];

  getGrid() {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          list.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 755),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: list[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
