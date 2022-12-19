import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/user.dart';
import 'package:flutter/material.dart';

class Product {
  static String? path = "product";
  static String? imagePath = "product-images";
  @required
  String? id;
  @required
  String image;
  @required
  String? name;
  @required
  int? price;
  int? rentPrice;
  @required
  int? deposit;
  @required
  String? location;
  int? deposit;
  String? img;
  DocumentReference? ownerRef;
  @required
  DocumentReference<Map<String, dynamic>> category;
  @required
  DocumentReference<Map<String, dynamic>> subcategory;
  @required
  String? description;

  Product({this.id,this.name,this.price,this.location,this.img,this.ownerRef,this.rentPrice,this.deposit});
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
      id :id,
      name: json['name'],
      price: json['price'],
      location: json['location'],
      img : json['img'],
      ownerRef : json['owner'],
      rentPrice: json['rent_price'],
      deposit: json['deposit_price']
    );
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
  DocumentReference toReference (){
    var path = "product/$id";
    return FirebaseFirestore.instance.doc(path);
  }

}
