import 'package:ecommerce_app/screens/product_details.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Blazer1",
      "picture": "assets/images/products/blazer1.jpeg",
      "old_price": 100,
      "price": 90,
    },
    {
      "name": "Blazer2",
      "picture": "assets/images/products/blazer2.jpeg",
      "old_price": 120,
      "price": 105,
    },
    {
      "name": "Dress1",
      "picture": "assets/images/products/dress1.jpeg",
      "old_price": 99,
      "price": 90,
    },
    {
      "name": "Hills1",
      "picture": "assets/images/products/hills1.jpeg",
      "old_price": 150,
      "price": 135,
    },
    {
      "name": "Hills2",
      "picture": "assets/images/products/hills2.jpeg",
      "old_price": 100,
      "price": 90,
    },
    {
      "name": "Pants1",
      "picture": "assets/images/products/pants1.jpg",
      "old_price": 100,
      "price": 90,
    },
    {
      "name": "Pants2",
      "picture": "assets/images/products/pants2.jpeg",
      "old_price": 200,
      "price": 190,
    },
    {
      "name": "Shoe1",
      "picture": "assets/images/products/shoe1.jpg",
      "old_price": 160,
      "price": 145,
    },
    {
      "name": "skt1",
      "picture": "assets/images/products/skt1.jpeg",
      "old_price": 100,
      "price": 90,
    },
    {
      "name": "skt2",
      "picture": "assets/images/products/skt2.jpeg",
      "old_price": 100,
      "price": 90,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return SingleProd(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class SingleProd extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  const SingleProd(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Hero(
        tag: Text(prod_name),
        child: Material(
          child: InkWell(
            onTap: () {
              var p = ProductDetails(
                product_detail_name: prod_name,
                product_detail_old_price: prod_old_price,
                product_detail_picture: prod_picture,
                product_detail_price: prod_price,
              );
              Navigator.pushNamed(context, '/productdetails', arguments: p);
            },
            child: GridTile(
              footer: Container(
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        prod_name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    new Text(
                      '\$$prod_price',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              child: Image.asset(
                prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
