import 'package:flutter/material.dart';
import 'package:food_app/src/auth/auth.dart';
import 'package:food_app/src/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usrNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Your email',
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 10.0,
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      controller: usrNameController,
      decoration: InputDecoration(
        hintText: 'Your username',
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 10.0,
        ),
      ),
    );
  }

  bool _togglevisibility = true;

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          hintText: 'Your password',
          hintStyle: TextStyle(
            color: Color(0xFFBDC2CB),
            fontSize: 10.0,
          ),
          suffixIcon: IconButton(
            icon: _togglevisibility
                ? Icon(
                    Icons.visibility,
                  )
                : Icon(
                    Icons.visibility_off,
                  ),
            onPressed: () {
              setState(() {
                _togglevisibility = !_togglevisibility;
              });
            },
          )),
      obscureText: _togglevisibility,
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      validator: (value) {
        if (value != passwordController.text) {
          return 'your password not match';
        }
        return null;
      },
      controller: ConfirmPasswordController,
      decoration: InputDecoration(
          hintText: 'Your password again',
          hintStyle: TextStyle(
            color: Color(0xFFBDC2CB),
            fontSize: 10.0,
          ),
          suffixIcon: IconButton(
            icon: _togglevisibility
                ? Icon(
                    Icons.visibility,
                  )
                : Icon(
                    Icons.visibility_off,
                  ),
            onPressed: () {
              setState(() {
                _togglevisibility = !_togglevisibility;
              });
            },
          )),
      obscureText: _togglevisibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    _buildNameTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildEmailTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildConfirmPasswordTextField(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                print('dddddddd');
                handleSignUp();
              },
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Color(0xFFBDC2CB),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => SignInPage(),
                    ));
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  handleSignUp() async {
    Auth auth = Auth();
    var ret = await auth.signUp(emailController.text, passwordController.text);
    print(ret);
  }
}
