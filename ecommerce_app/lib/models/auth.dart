import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FBApi {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseUser firebaseUser;

  FBApi(FirebaseUser user) {
    this.firebaseUser = user;
  }

  static Future<FBApi> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(authCredential);

    // final FirebaseUser user = await _auth.signInWithGoogle(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );

    assert(user.email != null);
    assert(user.displayName != null);

    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return FBApi(user);
  }
  static Future<bool> isSigned() async{
    return _googleSignIn.isSignedIn();
  }

  static Future<FBApi> SignInWithEmail(String email,String password) async {
    FirebaseUser result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return FBApi(result);
  }
}

//--------------google signin -------------------
                        // Padding(
                        //   padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
                        //   child: Text(
                        //     'Other signin options',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white70,
                        //         //decorationStyle: TextDecorationS8tyle.wavy,
                        //         fontSize: 15),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Material(
                        //     borderRadius: BorderRadius.circular(20),
                        //     color: Colors.red.withOpacity(0.8),
                        //     elevation: 0.0,
                        //     child: Padding(
                        //         padding: const EdgeInsets.all(0.0),
                        //         child: MaterialButton(
                        //           minWidth: MediaQuery.of(context).size.width,
                        //           child: Text(
                        //             'login with google',
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 20),
                        //           ),
                        //           onPressed: () async {
                        //             setState(() => _isLoading = true);
                        //             bool b = await _loginUser();
                        //             setState(() => _isLoading = false);
                        //             if (b == true) {
                        //               Navigator.pushReplacement(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) =>
                        //                           HomePage()));
                        //             } else {
                        //               Scaffold.of(context).showSnackBar(
                        //                   SnackBar(
                        //                       content: Text("Wrong email or")));
                        //             }
                        //           },
                        //         )),
                        //   ),
                        // ),