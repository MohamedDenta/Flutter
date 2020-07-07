import 'package:ecommerce_app/models/connectivity.dart';
import 'package:ecommerce_app/models/firebase_provider.dart';
import 'package:ecommerce_app/screens/account_screen.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/screens/yours_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/addressbook_screen.dart';
import 'screens/countrylang_screen.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConnectivityService(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // theme:  myThemeData,
      theme: myThemeData,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/productdetails": (context) => ProductDetails(),
        "/cart": (context) => Cart(),
        "/login": (context) => LoginWithGoogle(),
        "/account": (context) => AccountScreen(),
        "/yours": (context) => YourScreen(),
        "/addressbook":(context) => AddressBookScreen(),
        "/countrylang":(context) => CountryLangScreen(),
      },
    );
  }
}
