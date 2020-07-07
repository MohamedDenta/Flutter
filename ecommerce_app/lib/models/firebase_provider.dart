import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'user.dart';

class FirebaseProvider with ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User _user = new User();
  User get user => _user;
  getInstance() {
    if (_firebaseAuth.currentUser() == null) {
      return;
    }
    _firebaseAuth.currentUser().then((onValue) {
      //     username = onValue.displayName;
      //     photoUrl =
      //         'https://lh3.googleusercontent.com/a-/AOh14GjRNDn2Z2BiLtKNwhTAq-BhwxM2LFTfsAA8_5bvMw=s96-c'; //onValue.photoUrl;
      //     email = onValue.email;
      //     currentUser = onValue;
      //   });
      // }
      _user.email = onValue.email;
      _user.name = onValue.displayName;

      notifyListeners();
    });
  }

  logout() {
    FirebaseAuth.instance.signOut().then((onValue) {
      //_user = User();
      notifyListeners();
    });
  }
}
