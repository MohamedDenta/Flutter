import 'dart:io';

import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/provider/firebase_provider.dart';
import 'package:ecommerce_app/models/user.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var avatarImg;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FirebaseProvider>(context, listen: false);

    //bloc.updateUser(bloc.user);
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Account, 'My Account'),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.16,
            child: getCover(bloc),
          ),
          Expanded(
            child: getListInfo(),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.17,
            child: getFooter(),
          ),
        ],
      ),
    );
  }

  getCover(FirebaseProvider b) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: InkWell(
              onTap: pickImage,
              child: CircleAvatar(
                //backgroundImage: new FileImage(b.user.avatar),
                minRadius: 20,
                maxRadius: 40,
                backgroundColor: Colors.white30,
                child: avatarImg == null
                    ? Icon(
                        Icons.person_pin,
                        size: 40,
                      )
                    : Container(
                        // width: 200,
                        // height: 200,
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
          ),
          b.user.name == null ? Text('') : Text(b.user.name),
          b.user.email == null
              ? Text('No user registered')
              : Text(b.user.email),
        ],
      ),
    );
  }

  getListInfo() {
    return ListView(
      children: <Widget>[
        // ListTile(
        //   title: Text('My orders'),
        //   leading: Icon(Icons.directions_bus),
        // ),
        // ListTile(
        //   title: Text('My wishlist'),
        //   leading: Icon(Icons.favorite),
        // ),
        ListTile(
          title: Text('Personal Info'),
          leading: Icon(Icons.person_pin),
          onTap: () {
            Navigator.of(context).pushNamed('/yours');
          },
        ),

        // ListTile(
        //   title: Text('My address book'),
        //   leading: Icon(Icons.library_books),
        //   onTap: () {
        //     Navigator.of(context).pushNamed('/addressbook');
        //   },
        // ),
        ListTile(
          title: Text('Country and languages'),
          leading: Icon(Icons.call_missed_outgoing),
          onTap: () {
            Navigator.of(context).pushNamed('/countrylang');
          },
        ),
        // ListTile(
        //   title: Text('Communication Preferences'),
        //   leading: Icon(Icons.add_alert),
        // ),
        ListTile(
          title: Text('Help Center'),
          leading: Icon(Icons.info_outline),
        ),
        ListTile(
          title: Text('Share with friends'),
          leading: Icon(Icons.share),
          onTap: () async {
            await Share.share('rate us on google play \n'
                'https://play.google.com/store/apps/details?id=com.denta.azkar');
          },
        ),
        ListTile(
          title: Text('Leave feedback'),
          leading: Icon(Icons.feedback),
        ),
        ListTile(
          title: Text('Rate us on play store'),
          leading: Icon(Icons.favorite),
          onTap: () async {
            OpenAppstore.launch(androidAppId: "com.denta.azkar", iOSAppId: "");
          },
        ),
      ],
    );
  }

  Widget getFooter() {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width,
      color: Colors.white30,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Image.asset('assets/icons/app.png')],
          ),
          Text('Denta , 2020'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('privacy policy '),
              Text(' | '),
              Text(' terms & conditions'),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> pickImage() async {
    final userBloc = Provider.of<FirebaseProvider>(context);

    final ImagePicker _picker = ImagePicker();
    var pickedImg = await _picker.getImage(source: ImageSource.gallery);
    if (pickedImg != null) {
      setState(() {
        avatarImg = new File(pickedImg.path);
        userBloc.updateUser(User(
            name: userBloc.user.name,
            email: userBloc.user.email,
            avatar: ''));
      });
    }
  }
}
