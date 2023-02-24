import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/order.dart';

class OrderRepository {
  final firestore = FirebaseFirestore.instance.collection(Order.path);

  Future<String> checkout(Order order) async {
    var doc = firestore.doc(order.id);
    return doc
        .set(order.toFirestore(),SetOptions(merge: true))
        .then((value) => doc.id)
        .onError((error, stackTrace) {
      // log("+++ checkout $error \n$stackTrace");
      return "";
    });
  }

  Stream<List<Order>> getAllOrderByOwner (String ownerId){
    var ownerRef = FirebaseFirestore.instance.doc("/user/$ownerId");
    return firestore.where("owner",isEqualTo: ownerRef).orderBy("issue_date",descending:true).snapshots().map((snapshot) {
      List<Order> orderList = Order.fromSnapshot(snapshot.docs);
      return orderList;
    });

  }

  Future<bool> updateOrder(Order order) async {
    return firestore.doc(order.id).set(order.toFirestore(),SetOptions(merge: true)).then((value) => true).onError((error, stackTrace) => false);
  }

}
