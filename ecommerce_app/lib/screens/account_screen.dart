import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/firebase_provider.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var avatarImg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<FirebaseProvider>(context, listen: false);
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
            height: MediaQuery.of(context).size.height*0.17,
            child: getFooter(),
          ),
        ],
      ),
    );
  }

  getCover(FirebaseProvider b) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CircleAvatar(
              minRadius: 1.0,
              backgroundColor: Colors.white30,
              child: b.user.avatar == null
                  ? Icon(Icons.cloud_upload)
                  : Container(
                      // width: 200,
                      // height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: new FileImage(b.user.avatar),
                          fit: BoxFit.cover,
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
          title: Text('Yours'),
          leading: Icon(Icons.person_pin),
          onTap: (){
            Navigator.of(context).pushNamed('/yours');
          },
        ),

        ListTile(
          title: Text('My address book'),
          leading: Icon(Icons.library_books),
          onTap: (){
            Navigator.of(context).pushNamed('/addressbook');
          },
        ),
        ListTile(
          title: Text('Contry and languages'),
          leading: Icon(Icons.call_missed_outgoing),
          onTap: (){
            Navigator.of(context).pushNamed('/countrylang');
          },
        ),
        ListTile(
          title: Text('Communication Preferences'),
          leading: Icon(Icons.add_alert),
        ),
        ListTile(
          title: Text('Help Center'),
          leading: Icon(Icons.info_outline),
        ),
        ListTile(
          title: Text('Share with friends'),
          leading: Icon(Icons.share),
        ),
        ListTile(
          title: Text('Leave feedback'),
          leading: Icon(Icons.feedback),
        ),
        ListTile(
          title: Text('Rate us on play store'),
          leading: Icon(Icons.favorite),
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
}
