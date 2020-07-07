import 'package:firebase_database/firebase_database.dart';
class UserServices {
  UserServices();
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";
  createUser(String uid,Map value){
    print(value);
    _database.reference().child(uid).push().set(value).catchError((e)=>{
      print(e.toString())
    }).catchError((err)=>{
      print(err.toString())
    });
  }
}