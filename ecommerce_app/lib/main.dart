import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // theme:  myThemeData,
      theme: myThemeData,
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/": (context) => HomeScreen(),
        "/productdetails": (context) => ProductDetails(),
        "/cart": (context) => Cart(),
        "/login": (context) => LoginWithGoogle(),
      },
    );
  }
}
