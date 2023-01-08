import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  static String path = "category";
  String? id;
  String? olahraga;

  Category(this.id, this.olahraga);

  static Category fromDocument(String id, Map<String, dynamic> data) {
    return Category(id, data['olahraga']);
  }

  static List<Category> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) {
      return Category.fromDocument(e.id, e.data());
    }).toList();
  }

  // static IconData toIcon(String name) {
  //   return FontAwesomeIcons.createDo;
  // }
}
