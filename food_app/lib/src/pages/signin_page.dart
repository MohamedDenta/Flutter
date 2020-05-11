import 'package:flutter/material.dart';
import 'package:food_app/src/pages/signup_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Your email or username',
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
                'Sign In',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            SizedBox(
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'forgotten password?',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(
                      height: 20,
                    ),
                    _buildPasswordTextField(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
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
                  'Don\'t have an account?',
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
                      builder: (BuildContext context) => SignUpPage(),
                    ));
                  },
                  child: Text(
                    'Sign up',
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
}
