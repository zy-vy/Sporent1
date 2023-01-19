import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporent/model/owner.dart';
import 'package:sporent/model/product.dart';

import 'abstract_model.dart';

class UserLocal extends BaseModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? image;
  String? birthdate;
  int? deposit;
  bool? isOwner;
  String? owner_name;
  String? owner_image;
  int? owner_balance;
  String? owner_municipality;
  String? owner_address;
  String? owner_description;

  UserLocal(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.image,
      this.birthdate,
      this.deposit,
      this.isOwner,
      this.owner_name,
      this.owner_image,
      this.owner_balance,
      this.owner_municipality,
      this.owner_address,
      this.owner_description});

  factory UserLocal.toOwner(UserLocal user, List<Product>? list) {
    (user as Owner).listProduct = list;
    return user;
  }

  static UserLocal fromDocument(String id, Map<String, dynamic> json) {
    return UserLocal(
        id: id,
        name: json['name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        image: json['image'],
        birthdate: json['birthdate'],
        deposit: json['deposit'],
        isOwner: json['is_owner'],
        owner_name: json['owner_name'],
        owner_image: json['owner_image'],
        owner_balance: json['owner_balance'],
        owner_municipality: json['owner_municipality'],
        owner_address: json['owner_address'],
        owner_description: json['owner_description']);
  }

  static List<UserLocal> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phoneNumber != null) "phone_number": phoneNumber,
      if (image != null) "image": image,
      if (birthdate != null) "birthdate" : birthdate,
      if (deposit != null) "deposit" : deposit,
      if (owner_name != null) "owner_name": owner_name,
      if (owner_image != null) "owner_image": owner_image,
      if (owner_balance != null) "owner_balance": owner_balance,
      if (owner_municipality != null) "owner_municipality": owner_municipality,
      if (owner_address != null) "owner_address": owner_address,
      if (owner_description != null) "owner_description": owner_description,
    };
  }

  DocumentReference<Map<String, dynamic>> toReference() {
    var path = "user/$id";
    return FirebaseFirestore.instance.doc(path);
  }

  factory UserLocal.fromAuth(User user) {
    return UserLocal(
      name: user.displayName,
      email: user.email,
      phoneNumber: user.phoneNumber,
    );
  }
}
