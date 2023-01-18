import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Deposit {
  String? id;
  DateTime? date;
  int? amount;
  String? status;
  DocumentReference<Map<String, dynamic>>? detail_id;
  DocumentReference<Map<String, dynamic>>? user;

  Deposit(
      {this.id,
      this.date,
      this.amount,
      this.status,
      this.detail_id,
      this.user});

  static Deposit fromDocument(String id, Map<String, dynamic> json) {
    return Deposit(
        id: id,
        date: json['date'].toDate(),
        amount: json['amount'],
        status: json['status'],
        detail_id: json['detail_id'],
        user: json['user']);
  }

  static List<Deposit> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "amount": amount,
        "status": status,
        "detail_id": detail_id,
        "user" : user
      };

}
