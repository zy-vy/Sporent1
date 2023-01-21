import 'package:cloud_firestore/cloud_firestore.dart';

class Complain {
  final String? id;
  final String? status;
  final DocumentReference? transaction;

  const Complain(
      {this.id,
      this.status,
      this.transaction});

  static Complain fromDocument(String id, Map<String, dynamic> json) {
    return Complain(
      id: id,
      status: json['status'],
      transaction: json['transaction'],
    );
  }
  
  toJSON() {
    return {
      "status" : status,
      "transaction": transaction,
    };
  }
}
