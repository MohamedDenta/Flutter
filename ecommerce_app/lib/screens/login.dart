import 'package:ecommerce_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  bool _isgoogleLoading = false;
  _LoginWithGoogleState() {
    isLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    String s = 'Login';
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          s,
          style: TextStyle(color: Colors.red.shade900),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: getBody(context),
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

  Future<void> saveToPreference() async {
    firebaseAuth.currentUser().then((onValue) async {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("email", _emailTextController.text);
      sharedPreferences.setString("username", onValue.displayName);
      sharedPreferences.setString("photourl", onValue.photoUrl);
    });
  }

  void saveToPreference2(FirebaseUser user) async {
    print(user.toString());
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("id", user.uid);
    sharedPreferences.setString("username", user.displayName);
    sharedPreferences.setString("photourl", user.photoUrl);
  }

  void isLoggedin() async {
    firebaseAuth.currentUser().then((onValue) {
      if (onValue == null) {
        setState(() {
          _isLoading = false;
        });
        print('no user......');
      } else {
        saveToPreference().then((onValue) {
          Navigator.pushReplacementNamed(context, '/');
        });
      }
    });
  }

  Widget getBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: getForm(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getCoverImage() {
    return Container(
      alignment: Alignment.topCenter,
      child: Image.asset(
        'assets/images/lg.png',
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.3,
      ),
    );
  }

  Widget getForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            createField(getEmailForm()),
            createField(getPasswordField()),
            //****************login button  */
            createBtn(getLoginButton(context)),
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
                child: Row(
                  children: <Widget>[
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
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

            _isgoogleLoading
                ? Container(
                    child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ))
                : createBtn(getGoogleBtn(context)),
          ],
        ));
  }

  Widget getEmailForm() {
    return TextFormField(
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
          }
          return null;
        }
        return 'please enter email';
      },
    );
  }

  Widget getPasswordField() {
    return TextFormField(
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
        return null;
      },
    );
  }

  Widget createField(Widget fieldForm) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.5),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: fieldForm,
        ),
      ),
    );
  }

  Widget getLoginButton(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      child: Text(
        'login',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      onPressed: () {
        setState(() {
          _isLoading = true;
        });
        FBApi.signInWithEmail(
                _emailTextController.text, _passwordTextController.text)
            .then((onValue) {
          setState(() {
            _isLoading = false;
          });
          isLoggedin();
        }).catchError((onError) {
          setState(() {
            _isLoading = false;
          });
          print(onError.toString());
          PlatformException err = onError;
          
          showDialog(context: context , child: AlertDialog(content: Text(err.message),title: Text('login failure' , ),actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: (){
                Navigator.of(context).pop(true);
              },
            )
          ], ));
          print('....................................');
        });
      },
    );
  }

  Widget createBtn(Widget btn) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.withOpacity(0.8),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: btn,
        ),
      ),
    );
  }

  Widget getGoogleBtn(BuildContext context) {
    return Material(
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
              setState(() {
                _isgoogleLoading = true;
              });
              FBApi.signInWithGoogle().then((onValue) {
                setState(() {
                  _isgoogleLoading = false;
                });

                Navigator.pushReplacementNamed(context, '/');
              }).catchError((onError) {
                setState(() {
                  _isgoogleLoading = false;
                });
                Fluttertoast.showToast(
                    msg: 'error occured during login! ${onError.toString()}',
                    backgroundColor: Colors.black38);
                print(onError.toString());
              });
            },
          )),
    );
  }
}
