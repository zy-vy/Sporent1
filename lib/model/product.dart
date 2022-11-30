import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  // String id;
  String? id;
  String? name;
  int? price;
  String? location;
  String? img;

  Product(this.id,this.name,this.price,this.location,this.img);

  static Product fromDocument (String id,Map<String, dynamic> json){
    return Product(
      id,
      json['name'],
      json['price'],
      json['location'],
      json['img']
    );
  }

  static List<Product> fromSnapshot( List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots){
    return snapshots.map((e) => fromDocument(e.id,e.data())).toList();
  }

}