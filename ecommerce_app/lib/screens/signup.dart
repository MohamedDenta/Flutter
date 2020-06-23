import 'package:ecommerce_app/screens/home_screen.dart';
import 'login.dart';
import '../models/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  TextEditingController _confirmPasswordTextController =
      new TextEditingController();
  TextEditingController _nameTextController = new TextEditingController();
  UserServices _userServices = new UserServices();

  String gender = "male";
  bool _isLoading = false;
  bool hidePass1 = true;
  bool hidePass2 = true;
  String groupValue = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Signup",
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
                          //------------- Full name --------------------
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  controller: _nameTextController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "full name",
                                    icon: Icon(Icons.person),
                                    border: InputBorder.none,
                                  ),
                                  //obscureText: true,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'full name is required';
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),

                          //*********email */
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextFormField(
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                    hintText: "email",
                                    border: InputBorder.none,
                                    icon: Icon(Icons.alternate_email),
                                  ),
                                  validator: (value) {
                                    if (value.isNotEmpty) {
                                      Pattern pattern =
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                                      RegExp exp = new RegExp(pattern);
                                      if (!exp.hasMatch(value)) {
                                        return 'invalid email';
                                      } else if (value.isEmpty) {
                                        return 'email is required';
                                      } else {
                                        return null;
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          // ---- Gender -------
                          Container(
                            color: Colors.white.withOpacity(0.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "male",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Radio(
                                      value: "male",
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e),
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "female",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Radio(
                                      value: "female",
                                      groupValue: groupValue,
                                      onChanged: (e) => valueChanged(e),
                                      activeColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
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
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _passwordTextController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "password",
                                      icon: Icon(Icons.lock_outline),
                                      border: InputBorder.none,
                                    ),
                                    obscureText: hidePass1,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'password is required';
                                      }
                                      if (value.length < 6) {
                                        return 'password must be > 5 characters';
                                      }

                                      return null;
                                    },
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: hidePass1
                                          ? Colors.blue.shade900
                                          : Colors.black87,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        hidePass1 = !hidePass1;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //------------- confirm password --------------------
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _confirmPasswordTextController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: "confirm password",
                                      icon: Icon(
                                        Icons.lock_outline,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    obscureText: hidePass2,
                                    validator: (value) {
                                      // if (value.isEmpty) {
                                      //   return 'password is required';
                                      // }
                                      // if (value.length < 6) {
                                      //   return 'password must be > 5 characters';
                                      // }
                                      if (value !=
                                          _passwordTextController.text) {
                                        return 'two passwords not matched';
                                      }
                                    },
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: hidePass2
                                          ? Colors.blue.shade900
                                          : Colors.black87,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        hidePass2 = !hidePass2;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //****************signup button  */
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
                                      'signup',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    onPressed: () {
                                      validateForm();
                                    },
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Text(
                                  'signin',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginWithGoogle()));
                                },
                              )),
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

  void valueChanged(e) {
    setState(() {
      groupValue = e;
      gender = e;
    });
  }

  void validateForm() async {
    FormState formState = _formKey.currentState;
    if (formState.validate()) {
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) => {
                  _userServices.createUser(user.uid.toString(), {
                    "username": _nameTextController.text.toString(),
                    "email": user.email,
                    "userId": user.uid,
                    "gender": gender,
                  })
                })
            .catchError((err) => {print(err.toString())});
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    }
  }
}
