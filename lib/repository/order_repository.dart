import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/order.dart';

class OrderRepository {
  final firestore = FirebaseFirestore.instance.collection(Order.path);

  Future<bool> checkout(Order order) async {
    return firestore
        .doc()
        .set(order.toFirestore())
        .then((value) => true)
        .onError((error, stackTrace) {
      log("+++ checkout $error \n$stackTrace");
      return false;
    });
  }
}
