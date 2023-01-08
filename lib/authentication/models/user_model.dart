import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  final String? id;
  final String name;
  final String birthdate;
  final String email;
  final String phonenumber;
  final Timestamp? createdAt;

  const userModel(
      {this.id,
      required this.name,
      required this.birthdate,
      required this.email,
      required this.phonenumber,this.createdAt});

  toJSON() {
    return {
      "name": name,
      "birthdate": birthdate,
      "email": email,
      "phone_number": phonenumber,
      "created_at": createdAt
    };
  }
}
