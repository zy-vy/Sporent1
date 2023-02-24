import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/user.dart';
import 'package:flutter/material.dart';

class Product {
  static String? path = "product";
  static String? imagePath = "product-images";
  String? id;
  String? img;
  String? name;
  int? rent_price;
  int? deposit_price;
  String? location;
  DocumentReference<Map<String, dynamic>>? owner;
  DocumentReference<Map<String, dynamic>>? category;
  DocumentReference<Map<String, dynamic>>? subcategory;
  String? description;
  File? imageFile;

  Product(
      {this.id,
      this.img,
      this.name,
      this.rent_price,
      this.deposit_price,
      this.location,
      this.owner,
      this.category,
      this.subcategory,
      this.description,
      this.imageFile});

  static Product fromDocument(String id, Map<String, dynamic> json) {
    return Product(
      id: id,
      img: json['img'],
      name: json['name'],
      rent_price: json['rent_price'],
      deposit_price: json['deposit_price'],
      location: json['location'],
      owner: json['owner'],
      category: json['category'],
      subcategory: json['subcategory'],
      description: json['description'],
      
    );
  }

  static List<Product> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "img": img,
        "name": name,
        "rent_price": rent_price,
        "deposit_price": deposit_price,
        "location": location,
        "owner": owner,
        "category": category,
        "subcategory": subcategory,
        "description": description
      };

  DocumentReference toReference() {
    var path = "product/$id";
    return FirebaseFirestore.instance.doc(path);
  }
}
