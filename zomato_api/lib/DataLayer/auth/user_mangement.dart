import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zomato_api/DataLayer/auth/service_locator.dart';
import 'package:zomato_api/DataLayer/shared_pref_service.dart';
import 'package:zomato_api/UI/main_screen.dart';

class UserManagement {
  storeNewUser(user, context) {
    Firestore.instance
        .collection('/users')
        .add({'email': user.email, 'uid': user.uid}).then((value) {
      locator<SharedPrefService>().login();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()));
    }).catchError((e) {
      print(e);
    });
  }
}
