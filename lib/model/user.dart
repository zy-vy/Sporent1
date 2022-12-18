import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporent/model/owner.dart';
import 'package:sporent/model/product.dart';

import 'abstract_model.dart';

class UserLocal extends BaseModel{
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? photoUrl;
  String? location;
  Timestamp? createdAt;

  UserLocal({this.id, this.name, this.email, this.phoneNumber, this.photoUrl,this.createdAt,this.location}) ;

  factory UserLocal.toOwner(UserLocal user, List<Product>? list){
    (user as Owner).listProduct=list;
    return user;
  }

  static UserLocal fromDocument(String id, Map<String, dynamic> json) {
    return UserLocal(
        id: id,
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        photoUrl: json['photo_url'],
        createdAt: json['created_at'],
        location: json['location']
    );

  }

  static List<UserLocal> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String,dynamic> toFirestore (){
    return {
      if (name!=null) "name":name,
      if (email!=null) "email": email,
      if (phoneNumber!=null) "phone_number": phoneNumber,
      if (photoUrl!=null) "photo_url": photoUrl ,
      if (location!=null) "location": location ,
      if (createdAt!=null) "created_at": createdAt ,
    };
  }

  DocumentReference<Map<String, dynamic>> toReference (){
    var path = "user/$id";
    return FirebaseFirestore.instance.doc(path);
  }

  factory UserLocal.fromAuth (User user){
    return UserLocal(
        name: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL,
        );
  }

}
