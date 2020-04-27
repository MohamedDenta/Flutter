import 'package:azkar/screens/imageslider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme:  myThemeData,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"), 
      ],
      locale: Locale("ar", "AE"),
      theme: myThemeData,
      debugShowCheckedModeBanner: false,

      initialRoute: "/",
      routes: {
        "/": (context) => HomeScreen(),
         "/image-slider": (context) => ImageSlider(),
      },
    );
  }
}
