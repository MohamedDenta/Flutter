import 'package:azkar/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:splashscreen/splashscreen.dart';

class Splashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text(
          'يا أيها الذين آمنوا'
          'اذكروا الله ذكرا كثيرا',
          style: TextStyle(
            fontFamily: ArabicFonts.Aref_Ruqaa,
            fontSize: 19,
            fontWeight: FontWeight.bold,
            package: 'google_fonts_arabic',
          ),
        ),
        image: new Image.asset('assets/icons/app.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.white,
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
