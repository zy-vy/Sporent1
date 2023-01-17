import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/repository/user_repository.dart';

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

  Stream<List<Order>> getAllOrderByOwner (String ownerId){
    var ownerRef = FirebaseFirestore.instance.doc("/user/$ownerId");
    return firestore.where("owner",isEqualTo: ownerRef).snapshots().map((snapshot) {
      List<Order> orderList = Order.fromSnapshot(snapshot.docs);
      return orderList;
    });

  }


}
