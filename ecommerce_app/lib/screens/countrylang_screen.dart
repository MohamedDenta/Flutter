import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class CountryLangScreen extends StatefulWidget {
  @override
  _CountryLangScreenState createState() => _CountryLangScreenState();
}

class _CountryLangScreenState extends State<CountryLangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.CountryLang, 'Country&languages'),
      body:Column(
        children: <Widget>[
          
        ],
      ) ,
    );
  }
}
