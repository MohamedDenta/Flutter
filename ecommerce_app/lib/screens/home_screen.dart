import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/horizontal_list_view.dart';
import 'package:ecommerce_app/widgets/products.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences preferences;
  Widget carousel = Container(
    height: 200.0,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/images/c1.jpg'),
        AssetImage('assets/images/m1.jpeg'),
        AssetImage('assets/images/w1.jpeg'),
        AssetImage('assets/images/m2.jpg'),
      ],
      autoplay: false,
      //animationCurve: Curves.fastOutSlowIn,
      //animationDuration: Duration(milliseconds: 1000),
      dotSize: 4.0,
      indicatorBgPadding: 2.0,
    ),
  );
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    //  readPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, 'HOME', 'Fashapp'),
      drawer: getDrawer(),
      body: Container(
        child: ListView(
          children: <Widget>[
            carousel,
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Categories'),
            ),
            HorizontalList(),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Recent products'),
            ),
            Container(height: 200, child: Products()),
          ],
        ),
      ),
    );
  }

  Widget getDrawer() {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName:
                Text('account name'), //Text(preferences.getString('username')),
            accountEmail: Text('m.n@email.com'),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          getListItem(
              'HOME PAGE',
              Icon(
                Icons.home,
                size: 30,
              )),
          getListItem(
              'MY ACCOUNT',
              Icon(
                Icons.account_circle,
                size: 30,
              )),
          getListItem(
              'MY ORDERS',
              Icon(
                Icons.shopping_basket,
                size: 30,
              )),
          getListItem(
              'SHOPPING CART',
              Icon(
                Icons.dashboard,
                size: 30,
              )),
          getListItem(
              'FAVOURITES',
              Icon(
                Icons.favorite,
                size: 30,
              )),
          Divider(),
          getListItem(
              'SETTINGS',
              Icon(
                Icons.settings,
                size: 30,
              )),
          getListItem(
              'ABOUT',
              Icon(
                Icons.info,
                size: 30,
              )),
        ],
      ),
    );
  }

  Widget getListItem(String title, Icon icon) {
    return InkWell(
      child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontFamily: "Helvetica", fontSize: 18),
          ),
          leading: icon),
      onTap: () {
        handleTap(title);
      },
    );
  }

  void handleTap(String title) {
    switch (title) {
      case 'HOME PAGE':
        Navigator.popAndPushNamed(context, "/");
        break;
      case 'SHOPPING CART':
        Navigator.pushNamed(context, '/cart');
        break;
      default:
    }
  }

  Future<void> readPref() async {
    preferences = await SharedPreferences.getInstance();
  }
}
