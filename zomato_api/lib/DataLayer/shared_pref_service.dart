import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  
  logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('is-login', false);
  }
  login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('is-login', true);
  }

  Future<bool> isLogin () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('is-login');
  }
}