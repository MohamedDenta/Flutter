import 'dart:io';

import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/enums/connectivity_status.dart';
import 'package:ecommerce_app/models/provider/connectivity.dart';
import 'package:ecommerce_app/models/provider/firebase_provider.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/horizontal_list_view.dart';
import 'package:ecommerce_app/widgets/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences preferences;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String username;
  String photoUrl;
  File avatarImg ;
  FirebaseUser currentUser;
  Widget carousel = Container(
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

  bool isloading = false;

  String email;

  @override
  void initState() {
    avatarImg = null;

    firebaseAuth.currentUser().then((onValue) {
      if (onValue == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        setState(() {
          username = onValue.displayName;
          photoUrl =
              'https://lh3.googleusercontent.com/a-/AOh14GjRNDn2Z2BiLtKNwhTAq-BhwxM2LFTfsAA8_5bvMw=s96-c'; //onValue.photoUrl;
          email = onValue.email;
          currentUser = onValue;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final connectedBloc = Provider.of<ConnectivityService>(context);
    final userBloc = Provider.of<FirebaseProvider>(context);
    userBloc.getInstance();

    return Scaffold(
      appBar: connectedBloc.status == ConnectivityStatus.Offline
          ? MyAppBar.getAppBar(
              context, AppBarStatus.NoConnection, 'You are not connected')
          : MyAppBar.getAppBar(context, AppBarStatus.Home, 'Denta'),
      drawer: getDrawer(),
      body: connectedBloc.status == ConnectivityStatus.Offline
          ? getOfflineBody()
          : getOnlineBody(),
    );
  }

// Drawer
  Widget getDrawer() {
    final userBloc = Provider.of<FirebaseProvider>(context);
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: userBloc.user.name == null
                ? Text('')
                : Text(userBloc
                    .user.name), //Text(preferences.getString('username')),
            accountEmail: userBloc.user.email == null
                ? Text('email')
                : Text(userBloc.user.email),
            currentAccountPicture: getPic(context, userBloc),
          ),
          // getListItem(
          //   'HOME PAGE',
          //   Icon(
          //     Icons.home,
          //     size: 30,
          //   ),
          // ),
          getListItem(
              'MY ACCOUNT',
              Icon(
                Icons.account_circle,
                size: 30,
              )),
          // getListItem(
          //     'MY ORDERS',
          //     Icon(
          //       Icons.shopping_basket,
          //       size: 30,
          //     )),

          getListItem(
              'SHOPPING CART',
              Icon(
                Icons.dashboard,
                size: 30,
              )),
          // getListItem(
          //     'FAVOURITES',
          //     Icon(
          //       Icons.favorite,
          //       size: 30,
          //     )),
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
          getListItem(
              'LOGOUT',
              Icon(
                Icons.exit_to_app,
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
      case 'LOGOUT':
        setState(() {
          isloading = true;
        });
        firebaseAuth.signOut().then((onValue) {
          Navigator.pushReplacementNamed(context, '/login');
          isloading = false;
        });
        break;
      case 'SHOPPING CART':
        Navigator.pushNamed(context, '/cart');
        break;
      case 'MY ACCOUNT':
        Navigator.pushNamed(context, '/account');
        break;
      case 'ABOUT':
        var d = AboutDialog(
          applicationIcon: Image.asset('assets/icons/app.png'),
          applicationLegalese: 'denta.com',
          applicationName: 'Denta',
          applicationVersion: '1.0.0',
        );
        showDialog(context: context, child: d);
        break;
      default:
    }
  }

  Future<void> pickImage() async {
    final userBloc = Provider.of<FirebaseProvider>(context);

    final ImagePicker _picker = ImagePicker();
    var pickedImg = await _picker.getImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      setState(() {
      photoUrl = pickedImg.path;
      avatarImg = new File(pickedImg.path);

      userBloc.updateUser(User(name: userBloc.user.name, avatar: ''));
      //await uploadAvatar(userBloc.user.email , avatarImg);
      });
    }
  }

  Future<String> uploadAvatar(String imageName, File avatar) async {
    try {
      final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
      final storageRef = firebaseStorage.ref().child('users/$imageName');
      final StorageUploadTask task = storageRef.putFile(avatar);
      if (task.isComplete) {
        return storageRef.getDownloadURL();
      } else {
        return "";
      }
    } catch (e) {
      print("Erooooor " + e.toString());
    }

    // StorageTaskSnapshot snapshot = await firebaseStorage
    //     .ref()
    //     .child('users/${_emailTextController.text}')
    //     .putFile(avatar)
    //     .onComplete
    //     .catchError((onError){
    //       print(onError.toString());
    //     });

    // if (snapshot.error == null) {
    //   final Future<String> downloadUrl = snapshot.ref.getDownloadURL();
    //   return downloadUrl;
    // } else {
    //   return "";
    // }
    return "";
  }

  getOfflineBody() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  getOnlineBody() {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: carousel,
        ),
        // new Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text('Categories'),
        // ),
        Container(
          height: MediaQuery.of(context).size.height * 0.16,
          child: HorizontalList(),
        ),
        // Expanded(
        //   child: Container(),
        // ),
        // new Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text('Recent products'),
        // ),
        Expanded(
          child: Container(child: Products()),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Center(
            child: ListTile(
              title: Text(
                'All Rights reserved to Denta 2020',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getPic(BuildContext context, FirebaseProvider bloc) {
    // bloc.user.avatar = avatarImg;
    return GestureDetector(
      child: InkWell(
        onTap: pickImage,
        child: CircleAvatar(
          backgroundColor: Colors.white30,
          child: avatarImg == null
              ? Icon(Icons.cloud_upload)
              : Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      image: new FileImage(avatarImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
