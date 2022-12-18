import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<UserLocal?> getUserById(String id) async {
    var userRef = _firestore.collection("user").doc(id).get().then(
        (value) => UserLocal.fromDocument(value.id, value.data()!), onError: (e) {
      log("Failed to get user with id :$id");
      return null;
    });
    return userRef;
  }
  Future<UserLocal?> getUserByRef(String reference) async {
    var userRef = _firestore.doc(reference).get().then(
            (value) { return UserLocal.fromDocument(value.id, value.data()!);}, onError: (e) {
      log("Failed to get user with ref :$reference");
      return null;
    });
    return userRef;
  }
}
