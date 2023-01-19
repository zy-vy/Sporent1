import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/user.dart';

class TestUser{

  Future<UserLocal?> getUser() async{
    return await FirebaseFirestore.instance.doc("/user/FPeAMSInSTaH01yoDAd5L38JII32").get().then((value) => UserLocal.fromDocument(value.id, value.data()as Map<String,dynamic>));
  }

}