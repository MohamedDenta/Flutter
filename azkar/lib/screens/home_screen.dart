import 'package:azkar/screens/fehris_screen.dart';
import 'package:azkar/screens/mosabeha_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var current_selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مختصر النصيحة',
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontFamily: ArabicFonts.Tajawal,
            package: 'google_fonts_arabic',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      //drawer: MyDrawer(),
      body: Container(
        child: getBody(),
      ),
      bottomNavigationBar: getBottomNavBar(),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      current_selected = index;
    });
  }

  getBody() {
    switch (current_selected) {
      case 0:
        return FehrisScreen();
        break;
      case 1:
        return Mosabeha();
        break;
      // case 2:
      //   return FavoritesScreen();
      //   break;

      default:
        return FehrisScreen();
        break;
    }
  }

  getBottomNavBar() {
    return BottomNavigationBar(
      fixedColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: current_selected,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_numbered_rtl),
          title: Text('الفهرس'),
          activeIcon: Icon(
            Icons.format_list_numbered_rtl,
            color: Colors.deepOrange,
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(
              "assets/icons/5.ico",
            ),
            size: 40,
            color: current_selected == 1 ? Colors.deepOrange : Colors.grey,
          ),
          title: Text('المسبحة'),
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.star),
        //   title: Text('المفضلة'),
        //   activeIcon: Icon(
        //     Icons.star,
        //     color: Colors.deepOrange,
        //   ),
        // ),
      ],
      onTap: _onItemTapped,
    );
  }
}
