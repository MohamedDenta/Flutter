class Food {
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final double price;
  final double discount;
  final double ratings;

  Food(
      {this.id,
      this.name,
      this.imagePath,
      this.category,
      this.price,
      this.discount,
      this.ratings});
}

final foods = [
  Food(
    id: "1",
    name: "Hot Coffee",
    imagePath: "assets/images/breakfast.jpeg",
    category: "1",
    price: 22.0,
    discount: 33.5,
    ratings: 99.0,
  ),
  Food(
    id: "1",
    name: "drilled Chicken",
    imagePath: "assets/images/lunch.jpeg",
    category: "2",
    price: 12.0,
    discount: 34.5,
    ratings: 69.0,
  ),
];
