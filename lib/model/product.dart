import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  @required
  String? id;
  @required
  String image;
  @required
  String? name;
  @required
  int? price;
  @required
  int? deposit;
  @required
  String? location;
  @required
  DocumentReference<Map<String, dynamic>> category;
  @required
  DocumentReference<Map<String, dynamic>> subcategory;
  @required
  String? description;

  Product(this.id, this.image, this.name, this.price, this.deposit,
      this.location, this.category, this.subcategory, this.description);

  static Product fromDocument(String id, Map<String, dynamic> json) {
    return Product(
        id,
        json['image'],
        json['name'],
        json['price'],
        json['deposit'],
        json['location'],
        json['category'],
        json['subcategory'],
        json['description']);
  }

  static List<Product> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image" : image,
        "name": name,
        "price": price,
        "deposit": deposit,
        "location": location,
        "category": category,
        "subcategory" : subcategory,
        "description": description
      };
}
