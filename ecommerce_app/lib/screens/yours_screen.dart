import 'package:ecommerce_app/enums/appbar_states.dart';
import 'package:ecommerce_app/models/provider/firebase_provider.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class YourScreen extends StatefulWidget {
  @override
  _YourScreenState createState() => _YourScreenState();
}

class _YourScreenState extends State<YourScreen> {
  var userNameController = TextEditingController(text: 'user name');
  var emailController = TextEditingController(text: 'email');
  var passwordController = TextEditingController(text: 'password');
  var genderController = TextEditingController(text: 'gender');

  bool userNameEditMode = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<FirebaseProvider>(context);
    bloc.getInstance();
    readUserData(bloc);
    return Scaffold(
      appBar: MyAppBar.getAppBar(context, AppBarStatus.Your, ''),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              'Yours',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text('Browse what you want from the menu below'),
          ),
          Expanded(
            child: getGrid(),
          ),
        ],
      ),
    );
  }

  getGrid() {
    return AnimationLimiter(
      child: ListView(
        children: [
          getUserName(),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.edit_attributes),
              onPressed: () {},
            ),
            title: EditableText(
              backgroundCursorColor: Colors.redAccent,
              controller: emailController,
              cursorColor: Colors.redAccent,
              focusNode: FocusNode(canRequestFocus: true),
              style: TextStyle(fontSize: 20, color: Colors.black),
              readOnly: true,
            ),
            // onTap: () {},
          ),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.edit_attributes),
              onPressed: () {},
            ),
            title: EditableText(
              backgroundCursorColor: Colors.redAccent,
              controller: passwordController,
              cursorColor: Colors.redAccent,
              focusNode: FocusNode(canRequestFocus: true),
              style: TextStyle(fontSize: 20, color: Colors.black),
              readOnly: true,
              obscureText: true,
            ),
            // onTap: () {},
          ),
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.edit_attributes),
              onPressed: () {},
            ),
            title: EditableText(
              backgroundCursorColor: Colors.redAccent,
              controller: genderController,
              cursorColor: Colors.redAccent,
              focusNode: FocusNode(canRequestFocus: true),
              style: TextStyle(fontSize: 20, color: Colors.black),
              readOnly: true,
            ),
            // onTap: () {},
          ),
        ],
      ),
    );
  }

  void readUserData(FirebaseProvider bloc) {
    emailController.text = bloc.user.email;
    passwordController.text = bloc.user.password;
    genderController.text = bloc.user.gender;
    userNameController.text = bloc.user.name;
  }

  Widget getUserName() {
    return ListTile(
      trailing: IconButton(
        icon: !userNameEditMode
            ? Icon(Icons.edit_attributes)
            : Icon(
                Icons.edit_attributes,
                color: Colors.lightBlue,
              ),
        onPressed: () {
          print('object 00 ');
          userNameEditMode = !userNameEditMode;
        },
      ),
      title: EditableText(
        backgroundCursorColor: Colors.redAccent,
        controller: userNameController,
        cursorColor: Colors.redAccent,
        focusNode: FocusNode(canRequestFocus: false),
        style: TextStyle(fontSize: 20, color: Colors.black),
        readOnly: !userNameEditMode,
        onChanged: (String str) {
          userNameController.text = str;
        },
      ),
      // onTap: () {},
    );
  }
}
