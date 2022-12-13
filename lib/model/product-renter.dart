import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRenter {
  @required
  String? id;
  @required
  String? image;
  @required
  String? name;
  @required
  int? price;
   @required
  String? location;
  @required
  DocumentReference<Map<String, dynamic>> category;
  @required
  String? description;

  ProductRenter(this.id, this.image, this.name, this.price, this.location,
      this.category, this.description);

  static ProductRenter fromDocument(String id, Map<String, dynamic> json) {
    return ProductRenter(id, json['image'], json['name'], json['price'], json['location'], json['category'], json['description']);
  }

  static List<ProductRenter> fromSnapshot( List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots){
    return snapshots.map((e) => fromDocument(e.id,e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "location" : location,
        "category": category,
        "description": description
      };
}
