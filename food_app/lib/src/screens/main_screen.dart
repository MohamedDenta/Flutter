import 'package:flutter/material.dart';
import 'package:food_app/src/pages/favorite_page.dart';
import 'package:food_app/src/pages/home_page.dart';
import 'package:food_app/src/pages/order_page.dart';
import 'package:food_app/src/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;

  HomePage homePage;
  OrderPage orderPage;
  FavoritePage favoritePage;
  ProfilePage profilePage;
  @override
  void initState() {
    super.initState();
    homePage = HomePage();
    orderPage = OrderPage();
    favoritePage = FavoritePage();
    profilePage = ProfilePage();
    pages = [
      homePage,
      orderPage,
      favoritePage,
      profilePage,
    ];

    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentTabIndex == 1
          ? AppBar(
              title: Text(
                'Your Food Cart',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            )
          : null,
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.grey,
            ),
            title: Text(
              'Orders',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            activeIcon: Icon(
              Icons.shopping_cart,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.grey,
            ),
            title: Text(
              'Favorite',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            activeIcon: Icon(
              Icons.favorite,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            title: Text('Profile'),
            activeIcon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
