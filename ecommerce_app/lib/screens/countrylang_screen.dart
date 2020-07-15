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
      appBar: MyAppBar.getAppBar(
          context, AppBarStatus.CountryLang, 'Country&languages'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Select Language'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: languageSection,
          ),
          Divider(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Select Country'),
          ),
          countrySection,
        ],
      ),
    );
  }

  var languageSection = Column(
    children: <Widget>[
      ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('عربي'),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Text(
              'AR',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('English'),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Text(
              'EN',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            // TODO : call provider to change language
          },
        ),
      ),
    ],
  );

  var countrySection = Column(
    children: <Widget>[
      ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Egypt'),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Text(
              'EG',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            // TODO : call provider to change language
          },
        ),
      ),
      ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Kingdom Saudi Arabia'),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Text(
              'KSA',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        // trailing: IconButton(
        //   icon: Icon(Icons.check),
        //   onPressed: () {
        //     // TODO : call provider to change language
        //   },
        // ),
      ),
    ],
  );
}
