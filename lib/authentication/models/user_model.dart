import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  final String? id;
  final String name;
  final String birthdate;
  final String email;
  final String image;
  final bool is_owner;
  final String phonenumber;

  const userModel(
      {this.id,
      required this.name,
      required this.birthdate,
      required this.email,
      required this.image,
      required this.is_owner,
      required this.phonenumber});

  toJSON() {
    return {
      "name": name,
      "birthdate": birthdate,
      "email": email,
      "image" : image,
      "is_owner" : is_owner,
      "phone_number": phonenumber,
    };
  }
}
