import 'package:cloud_firestore/cloud_firestore.dart';

class complainModel {
  final String? id;
  final DocumentReference? transaction;
  final String? description;
  final List<String?> image;

  const complainModel(
      {this.id,
      required this.transaction,
      required this.description,
      required this.image});

  toJSON() {
    return {
      "transaction": transaction,
      "description": description,
      "image": image
    };
  }
}