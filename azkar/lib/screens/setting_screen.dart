import 'package:azkar/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: ListTile(
            leading: Text(
              'التنبيه علي أذكار الصباح',
              style: TextStyle(
                  fontFamily: ArabicFonts.Amiri,
                  package: 'google_fonts_arabic',
                  fontSize: 22),
            ),
            title: IconButton(
              icon: Const.NIGHT_MODE
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
              onPressed: () {
                setState(() {
                  Const.NIGHT_MODE = !Const.NIGHT_MODE;
                });
              },
            ),
          ),
        ),

        Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: ListTile(
            leading: Text(
              'التنبيه علي أذكار المساء',
              style: TextStyle(
                  fontFamily: ArabicFonts.Amiri,
                  package: 'google_fonts_arabic',
                  fontSize: 22),
            ),
            title: IconButton(
              icon: Const.NIGHT_MODE
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
              onPressed: () {
                setState(() {
                  Const.NIGHT_MODE = !Const.NIGHT_MODE;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
