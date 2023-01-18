import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Request {
  String? id;
  DateTime? date;
  int? amount;
  String? status;
  String? type;
  String? account_name;
  String? account_number;
  String? bank_name;
  DocumentReference<Map<String, dynamic>>? name_request;

  Request(
      {this.id,
      this.date,
      this.amount,
      this.status,
      this.type,
      this.account_name,
      this.account_number,
      this.bank_name,
      this.name_request});

  static Request fromDocument(String id, Map<String, dynamic> json) {
    return Request(
        id: id,
        date: json['date'].toDate(),
        amount: json['amount'],
        status: json['status'],
        type: json['type'],
        account_name: json['account_name'],
        account_number: json['account_number'],
        bank_name: json['bank_name'],
        name_request: json['name_request']);
  }

  static List<Request> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "date": date,
        "amount": amount,
        "status": status,
        "type": type,
        "account_name" : account_name,
        "account_number" : account_number,
        "bank_name" : bank_name,
        "name_request" : name_request
      };
}
