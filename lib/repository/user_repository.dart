import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class UserRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<User?> getUser(String id) async {
    var userRef = _firestore.collection("user").doc(id).get().then(
        (value) => User.fromDocument(value.id, value.data()!), onError: (e) {
      log("Failed to get user with id :$id");
      return null;
    });
    return userRef;
  }
  Future<User?> getUserByRef(String reference) async {
    var userRef = _firestore.doc(reference).get().then(
            (value) { return User.fromDocument(value.id, value.data()!);}, onError: (e) {
      log("Failed to get user with ref :$reference");
      return null;
    });
    return userRef;
  }
}
