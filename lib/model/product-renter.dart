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
  String? category;
  @required
  String? description;

  ProductRenter(this.id, this.image, this.name, this.price, 
      this.category, this.description);

  static ProductRenter fromDocument(String id, Map<String, dynamic> json) {
    return ProductRenter(id, json['image'], json['name'], json['price'], json['category'], json['description']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "category": category,
        "description": description
      };
}
