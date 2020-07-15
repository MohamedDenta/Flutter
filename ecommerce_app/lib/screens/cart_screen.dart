import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/cart_products.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Cart, "cart"),
      body: Cart_products(),
      bottomNavigationBar: new Container(
        color: Colors.white, 
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text('Total:'),
                subtitle: new Text('\$230'),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: new Text(
                  'Check out',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
