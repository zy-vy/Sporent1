import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Balance {
  String? id;
  DateTime? date;
  int? amount;
  String? status;
  DocumentReference<Map<String, dynamic>>? detail_id;
  DocumentReference<Map<String, dynamic>>? owner;

  Balance(
      {this.id,
      this.date,
      this.amount,
      this.status,
      this.detail_id,
      this.owner});

  static Balance fromDocument(String id, Map<String, dynamic> json) {
    return Balance(
        id: id,
        date: json['date'].toDate(),
        amount: json['amount'],
        status: json['status'],
        detail_id: json['detail_id'],
        owner: json['owner']);
  }

  static List<Balance> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "amount": amount,
        "status": status,
        "detail_id": detail_id,
        "owner" : owner
      };

}
