import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  Cart_products({Key key}) : super(key: key);

  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Blazer1",
      "picture": "assets/images/products/blazer1.jpeg",
      "old_price": 100,
      "price": 90,
      "size": "M",
      "color": "Red",
      "quantity": "1",
    },
    {
      "name": "Blazer2",
      "picture": "assets/images/products/blazer2.jpeg",
      "old_price": 120,
      "price": 105,
      "size": "M",
      "color": "Red",
      "quantity": "1",
    },
    {
      "name": "Dress1",
      "picture": "assets/images/products/dress1.jpeg",
      "old_price": 99,
      "price": 90,
      "size": "M",
      "color": "Red",
      "quantity": "1",
    },
    {
      "name": "Hills1",
      "picture": "assets/images/products/hills1.jpeg",
      "old_price": 150,
      "price": 135,
      "size": "M",
      "color": "Red",
      "quantity": "1",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return new Single_cart_product(
            cart_prod_name: Products_on_the_cart[index]['name'],
            cart_prod_color: Products_on_the_cart[index]['color'],
            cart_prod_qty: Products_on_the_cart[index]['quantity'],
            cart_prod_size: Products_on_the_cart[index]['size'],
            cart_prod_price: Products_on_the_cart[index]['price'],
            cart_prod_picture: Products_on_the_cart[index]['picture'],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  const Single_cart_product({
    Key key,
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(20.0),
        leading: new Image.asset(
          cart_prod_picture,
          // height: 200,
          width: 80,
          fit: BoxFit.cover,
        ),
        title: new Text(cart_prod_name),
        subtitle: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text('Size: '),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text('$cart_prod_size',
                      style: TextStyle(color: Colors.red)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8.0, 8.0, 8.0),
                  child: new Text('Color: '),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: new Text('$cart_prod_color',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: new Text('\$$cart_prod_price',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
            )
          ],
        ),
        trailing: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new IconButton(
                icon: Icon(Icons.arrow_drop_up),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '$cart_prod_qty',
              ),
            ),
            Expanded(
              child: new IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
