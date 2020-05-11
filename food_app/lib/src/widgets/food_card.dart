import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final imagePath;
  final numberOfItems;
  final categoryName;

  const FoodCard({this.imagePath, this.numberOfItems, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(imagePath),
              height: 65.0,
              width: 65.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  categoryName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                Text('$numberOfItems kinds'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
