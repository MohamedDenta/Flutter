import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserServices {
  UserServices();

  static String ref = "/users";
  createUser(BuildContext context, String id,Map<String,String> value) async {
    print(value);
    // _database.reference().child(uid).push().set(value).then((e)=>{
    //   print("write user to database *******************  ")
    // }).catchError((err)=>{
    //   print(err.toString())
    // });
    var curUsr =await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection(ref)
        .document(curUsr.uid) // use firebase user id  
        .setData(value)
        .then((v) {
          print("asd :-  ");
         // Navigator.of(context).pop();
          // Navigator.of(context).pushReplacementNamed('/');
        })
        .catchError((onError) {
          print("error in writing :-  ${onError.toString()}");
        });
  }

  static  Future<List<DocumentSnapshot>> getallusers() async {
    var doc = await Firestore.instance.collection(ref)
    .getDocuments();
    return doc.documents;
  }
}
