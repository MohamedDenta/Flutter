import 'package:ecommerce_app/services/user_service.dart';
import 'login.dart';
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
    return WillPopScope(
      child: Scaffold(
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
        body: getBody(),
        bottomNavigationBar: Container(
          // child: Center(
          child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : null),
          //),
        ),
      ),
      onWillPop: () => _onBackPressed(),
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
      print('validate ...');
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        setState(() {
          _isLoading = true;
        });
        firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then((user) {
          print('then reister');
          user.sendEmailVerification();
          UserUpdateInfo info = new UserUpdateInfo();
          info.displayName = _nameTextController.text;
          info.photoUrl =
              'https://lh3.googleusercontent.com/a-/AOh14GjRNDn2Z2BiLtKNwhTAq-BhwxM2LFTfsAA8_5bvMw=s96-c';
          user.updateProfile(info).then((onValue) {
            print('update done &&&');
          });
          /**
           * .then((onValue){
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('we sent verifivation email to you .'),));
          });
           */
          _userServices.createUser(user.uid.toString(), {
            "username": _nameTextController.text.toString(),
            "email": user.email,
            "userId": user.uid,
            "gender": gender,
          });
        }).catchError((err) {
          print(err.toString());
          setState(() {
            _isLoading = false;
          });
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(err.toString()),
          ));
        });
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        //firebaseAuth.signOut();
        print('already logged in');
      }
    } else {
      print("invalid ...........................");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('invalid data'),
      ));
    }
  }

  getBody() {
    return Stack(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: getForm(),
              ),
            ),
          ),
        ),
      ],

      //fit: StackFit.expand,
    );
  }

  getForm() {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            getNameField(),
            getEmailField(),
            Container(
              color: Colors.white.withOpacity(0.0),
              child: Row(
                children: <Widget>[
                  getMaleOption(),
                  getFemaleOption(),
                ],
              ),
            ),
            getPasswordField(),
            getConfirmPassword(),
            getSignupBtn(),
            getSigninBtn(),
          ],
        ));
  }

  getNameField() {
    return Padding(
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
              return null;
            },
          ),
        ),
      ),
    );
  }

  getEmailField() {
    return Padding(
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
              } else {
                return null;
              }
            },
          ),
        ),
      ),
    );
  }

  getMaleOption() {
    return Expanded(
      child: ListTile(
        title: Text(
          "male",
          style: TextStyle(color: Colors.black),
        ),
        trailing: Radio(
          value: "male",
          groupValue: groupValue,
          onChanged: (e) => valueChanged(e),
          activeColor: Colors.black,
        ),
      ),
    );
  }

  getFemaleOption() {
    return Expanded(
      child: ListTile(
        title: Text(
          "female",
          style: TextStyle(color: Colors.black),
        ),
        trailing: Radio(
          value: "female",
          groupValue: groupValue,
          onChanged: (e) => valueChanged(e),
          activeColor: Colors.black,
        ),
      ),
    );
  }

  getPasswordField() {
    return Padding(
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
                color: hidePass1 ? Colors.blue.shade900 : Colors.black87,
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
    );
  }

  getConfirmPassword() {
    return Padding(
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
                if (value != _passwordTextController.text) {
                  return 'two passwords not matched';
                }
                return null;
              },
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: hidePass2 ? Colors.blue.shade900 : Colors.black87,
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
    );
  }

  getSignupBtn() {
    return Padding(
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
    );
  }

  getSigninBtn() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Text(
            'signin',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginWithGoogle()));
          },
        ));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }
}
