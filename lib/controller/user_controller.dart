import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporent/model/user.dart';

class UserController {
  final _firestore = FirebaseFirestore.instance.collection("user");

  UserLocal? userLocal;

  Future<UserLocal?> getUser(String id) async {

    var user = _firestore
        .doc(id)
        .get()
        .then((value) => UserLocal.fromDocument(value.id, value.data()!),
        onError: (e) {
          log("Failed to get user with id :$id");
          return null;
        });
    return user;
  }


  Future<UserLocal?> getUserByRef(String reference) async {
    var userRef = _firestore.doc(reference).get().then((value) {
      return UserLocal.fromDocument(value.id, value.data()!);
    }, onError: (e) {
      log("Failed to get user with ref :$reference");
      return null;
    });
    return userRef;
  }

  Future<UserLocal?> createUserFromAuth(User user) async {
    var userLocal = await getUser(user.uid);
    inspect(userLocal);
    if(userLocal!=null){
      return userLocal;
    }

    userLocal = UserLocal.fromAuth(user);
    userLocal.createdAt = Timestamp.now();

    await _firestore.doc(user.uid).set(userLocal.toFirestore(),SetOptions(merge:true)).
    onError( (e, _) {
      log("failed to insert user :$e", level: 3);
    });

    return userLocal;
  }
}