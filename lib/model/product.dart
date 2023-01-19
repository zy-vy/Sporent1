import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/user.dart';
import 'package:flutter/material.dart';

class Product {
  static String? path = "product";
  static String? imagePath = "product-images";
  @required
  String? id;
  @required
  String? img;
  @required
  String? name;
  @required
  int? rentPrice;
  @required
  int? deposit;
  @required
  String? location;
  @required
  DocumentReference<Map<String, dynamic>> owner;
  @required
  DocumentReference<Map<String, dynamic>> category;
  @required
  DocumentReference<Map<String, dynamic>> subcategory;
  @required
  String? description;

  DocumentReference? ownerRef;
  File? imageFile;

  Product(this.id, this.img, this.name, this.rentPrice, this.deposit,
      this.location, this.owner, this.category, this.subcategory, this.description,{this.ownerRef});

  static Product fromDocument(String id, Map<String, dynamic> json) {
    return Product(
      id,
      json['img'],
      json['name'],
      json['rent_price'],
      json['deposit_price'],
      json['location'],
      json['owner'],
      json['category'],
      json['subcategory'],
      json['description'],
      ownerRef: json['owner']
    );
  }

  static List<Product> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "img" : img,
        "name": name,
        "rent_price": rentPrice,
        "deposit_price": deposit,
        "location": location,
        "owner" : owner,
        "category": category,
        "subcategory" : subcategory,
        "description": description
      };

  DocumentReference toReference (){
    var path = "product/$id";
    return FirebaseFirestore.instance.doc(path);
  }

}
