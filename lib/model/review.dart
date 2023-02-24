import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/authentication/models/user_model.dart';

class Review {
  String? id;
  String? detail;
  List<dynamic>? photo;
  DocumentReference<Map<String, dynamic>>? product;
  DocumentReference<Map<String, dynamic>>? user;
  int? star;

  Review(
      {this.id, this.detail, this.photo, this.product, this.user, this.star});

  static Review fromDocument(String id, Map<String, dynamic> json) {
    return Review(
        id: id,
        detail: json['detail'],
        photo: json['photo'],
        product: json['product'],
        user: json['user'],
        star: json['star']);
  }

  Map<String, dynamic> toJson() => {
        "detail": detail,
        "photo": photo,
        "product": product,
        "user": user,
        "star": star
      };

  static List<Review> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }
}
