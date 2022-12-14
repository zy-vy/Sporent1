import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sporent/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(userModel user) async {
    await _db
        .collection("user")
        .add(user.toJSON())
        .whenComplete(
          () => Get.snackbar("Success", "Your Account has been created.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue.withOpacity(0.1),
              colorText: Colors.blue),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Please try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withOpacity(0.1),
          colorText: Colors.blue);
      print(error.toString());
    });
  }
}
