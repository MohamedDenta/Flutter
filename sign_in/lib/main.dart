import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';

import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme:  myThemeData,
      theme: myThemeData,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
        "/signup": (context) => SignUpScreen(),
      },
    );
  }
}
