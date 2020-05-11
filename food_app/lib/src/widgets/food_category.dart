import 'package:flutter/material.dart';
import 'package:food_app/src/widgets/food_card.dart';

// Data
import '../data/category_data.dart';

// Model
import '../models/category_model.dart';

class FoodCategory extends StatelessWidget {
  final List<Category> _categories = categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return FoodCard(
            imagePath: _categories[index].imagePath,
            categoryName: _categories[index].categoryName,
            numberOfItems: _categories[index].numberOfItems,
          );
        },
      ),
    );
  }
}
