import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/products.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_old_price;
  final product_detail_price;
  ProductDetails(
      {this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_old_price,
      this.product_detail_price});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final ProductDetails arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Home,'Fashapp'),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                  color: Colors.white,
                  child: Image.asset(arguments.product_detail_picture)),
              footer: new Container(
                color: Colors.white,
                child: ListTile(
                  leading: new Text(
                    '${arguments.product_detail_name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text(
                          '\$${arguments.product_detail_old_price}',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: new Text(
                          '\$${arguments.product_detail_price}',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              getBtn('Size'),
              getBtn('Color'),
              getBtn('Quntity'),
            ],
          ),
          getSecondRow(),
          Divider(
            height: 5.0,
          ),
          new ListTile(
            title: new Text('Product details'),
            subtitle: new Text('This page shares my best articles '
                'to read on topics like health, happiness, creativity, '
                'productivity and more. The central question that drives '
                'my work is, “How can we live better?” To answer that question, '
                'I like to write about science-based ways to solve practical problems'),
          ),
          Divider(
            height: 5.0,
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  'Product name',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Text(
                  '${arguments.product_detail_name}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  'Product brand',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Text(
                  'Brand X',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  'Product condition',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Text(
                  'NEW',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Similar products'),
          ),
          Container(height: 300, child: Products()),
        ],
      ),
    );
  }

  Widget getSecondRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: MaterialButton(
              onPressed: () {},
              color: Colors.red,
              textColor: Colors.white,
              elevation: 0.2,
              child: new Text('Buy now')),
        ),
        new IconButton(
          icon: Icon(
            Icons.add_shopping_cart,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
        new IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget getBtn(String str) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return new AlertDialog(
                  title: new Text(str),
                  content: new Text('Choose the $str ?'),
                  actions: <Widget>[
                    new MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: new Text('Close'),
                    ),
                  ],
                );
              });
        },
        color: Colors.white,
        textColor: Colors.grey,
        elevation: 0.2,
        child: Row(
          children: <Widget>[
            Expanded(
              child: new Text(str),
            ),
            Expanded(
              child: new Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }
}
