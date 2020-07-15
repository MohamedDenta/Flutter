import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../user.dart';

class FirebaseProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User _user = new User();
  User get user => _user;
  set setuser(u) => _user = u;
  getInstance() {
    if (_firebaseAuth.currentUser() == null) {
      return;
    }
    _firebaseAuth.currentUser().then((onValue) async {
      var docs = await UserServices.getallusers();
      var b = false;
      for (var item in docs) {
        if (item['email'] == onValue.email) {
          _user.email = item['email'];
          _user.name = item['username'];
          _user.gender = item['gender'];
          _user.avatar = item['avatar'];
          UserUpdateInfo info = UserUpdateInfo();
          info.displayName = item['username'];
          info.photoUrl = item['avatar'];
          onValue.updateProfile(info);
          b = true;
          break;
        }
      }
      if (!b) {
        _user.email = onValue.email;
        _user.name = onValue.displayName;
      }
      notifyListeners();
    });
  }

  updateUser(User u) async {
    _user = u;
    var auth = await _firebaseAuth.currentUser();
    Firestore.instance.collection(UserServices.ref).document(auth.uid).setData({
      'username': u.name,
      'avatar': u.avatar,
    }, merge: true).then((onValue) {});
    var info = UserUpdateInfo();
    info.displayName = u.name;
    info.photoUrl = u.avatar;
    auth.updateProfile(info);
    notifyListeners();
  }

  logout() {
    FirebaseAuth.instance.signOut().then((onValue) {
      //_user = User();
      notifyListeners();
    });
  }
}
