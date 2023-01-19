import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Review {
  static String? path = "product";
  static String? imagePath = "product-images";
  @required
  String? id;
  @required
  String? detail;
  @required
  List<dynamic> photo;
  @required
  DocumentReference<Map<String, dynamic>> product;
  @required
  DocumentReference<Map<String, dynamic>> user;
  @required
  double? star;

  Review(this.id, this.detail, this.photo, this.product, this.user, this.star);

  static Review fromDocument(String id, Map<String, dynamic> json) {
    return Review(
        id, json['detail'], json['photo'], json['product'], json['user'], json['star']);
  }

  static List<Review> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }
}
