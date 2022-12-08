import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/user.dart';

class Product {

  // String id;
  String? id;
  String? name;
  int? price;
  int? rentPrice;
  String? location;
  String? img;
  DocumentReference? ownerRef;

  Product({this.id,this.name,this.price,this.location,this.img,this.ownerRef,this.rentPrice});

  static Product fromDocument (String id,Map<String, dynamic> json){
    return Product(
      id :id,
      name: json['name'],
      price: json['price'],
      location: json['location'],
      img : json['img'],
      ownerRef : json['owner'],
      rentPrice: json['rent_price']
    );
  }

  static List<Product> fromSnapshot( List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots){
    return snapshots.map((e) => fromDocument(e.id,e.data())).toList();
  }

}