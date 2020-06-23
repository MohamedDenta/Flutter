import 'package:ecommerce_app/models/auth.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'signup.dart';

class LoginWithGoogle extends StatefulWidget {
  @override
  _LoginWithGoogleState createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences sharedPreferences;
  bool _isLoading = false;
  bool isLoged = false;

  @override
  void initState() {
    super.initState();
    isLoggedin();
  }

  Future<bool> _loginUser() async {
    final api = await FBApi.signInWithGoogle();

    if (api != null) {
      saveToPreference(api);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(color: Colors.red.shade900),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          // Image.asset(
          //   'assets/images/lg.png',
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/lg.png',
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 140),
              child: Container(
                alignment: Alignment.center,
                child: Center(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: TextFormField(
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                      hintText: "email",
                                      icon: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Icon(Icons.alternate_email),
                                      )),
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      Pattern pattern =
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                                      RegExp exp = new RegExp(pattern);
                                      if (!exp.hasMatch(value)) {
                                        return 'invalid email';
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),

                          //------------- password --------------------
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: TextFormField(
                                  controller: _passwordTextController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "password",
                                    icon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Icon(Icons.lock_outline),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'password is required';
                                    }
                                    if (value.length < 6) {
                                      return 'password must be > 5 characters';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          //****************login button  */
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue.withOpacity(0.8),
                              elevation: 0.0,
                              child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'login',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    onPressed: () {
                                      FBApi.SignInWithEmail(
                                          _emailTextController.text,
                                          _passwordTextController.text);
                                          isLoggedin();
                                    },
                                  )),
                            ),
                          ),
                          // Expanded(child: Container(),),

                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'forget password',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                          ),

                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Other options',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    height: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red.withOpacity(0.8),
                              elevation: 0.0,
                              child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      'Google',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      _isLoading = true;
                                      FBApi.signInWithGoogle().then((onValue){
                                        _isLoading = false;
                                        Navigator.pushReplacementNamed(context, '/');
                                      });
                                    },
                                  )),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],

        //fit: StackFit.expand,
      ),
      bottomNavigationBar: Container(
        // child: Center(
        child: Padding(
            padding: const EdgeInsets.all(0.0),
            child:
                _isLoading ? Center(child: CircularProgressIndicator()) : null),
        //),
      ),
    );
  }

  void saveToPreference(FBApi api) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("id", api.firebaseUser.uid);
    sharedPreferences.setString("username", api.firebaseUser.displayName);
    sharedPreferences.setString("photourl", api.firebaseUser.photoUrl);
  }

  void saveToPreference2(FirebaseUser user) async {
    print(user.toString());
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("id", user.uid);
    sharedPreferences.setString("username", user.displayName);
    sharedPreferences.setString("photourl", user.photoUrl);
  }

  void isLoggedin() async {
    setState(() {
      _isLoading = true;
    });

    await firebaseAuth.currentUser().then((user) {
      if (user != null) {
        setState(() {
          isLoged = true;
        });
        saveToPreference2(user);
      }
    });
    
    sharedPreferences = await SharedPreferences.getInstance();
    isLoged = await FBApi.isSigned();
    if (isLoged) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    setState(() {
      _isLoading = false;
    });
  }
}
