import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/user.dart';

class Product {
  static String? path = "product";
  static String? imagePath = "product-images";
  String? id;
  String? name;
  int? rentPrice;
  String? location;
  int? deposit;
  String? img;
  DocumentReference? ownerRef;

  Product({this.id,this.name,this.location,this.img,this.ownerRef,this.rentPrice,this.deposit});

  static Product fromDocument (String id,Map<String, dynamic> json){
    return Product(
      id :id,
      name: json['name'],
      location: json['location'],
      img : json['img'],
      ownerRef : json['owner'],
      rentPrice: json['rent_price'],
      deposit: json['deposit_price']
    );
  }

  static List<Product> fromSnapshot( List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots){
    return snapshots.map((e) => fromDocument(e.id,e.data())).toList();
  }

  DocumentReference toReference (){
    var path = "product/$id";
    return FirebaseFirestore.instance.doc(path);
  }

}