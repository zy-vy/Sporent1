import 'package:cloud_firestore/cloud_firestore.dart';

class Complain {
  final String? id;
  final String? status;
  final DateTime? date;
  final String? conclusion;
  final DocumentReference? transaction;

  const Complain(
      {this.id, this.status, this.transaction, this.date, this.conclusion});

  static Complain fromDocument(
      String id, Map<String, dynamic> json, bool completeOrNot) {
    if (completeOrNot == true) {
      return Complain(
        id: id,
        status: json['status'],
        date: json['date'].toDate(),
        conclusion: json['conclusion'],
        transaction: json['transaction'],
      );
    }
    else{
      return Complain(
        id: id,
        status: json['status'],
        transaction: json['transaction'],
      );
    }
  }

  toJSON() {
    return {
      "date": date,
      "status": status,
      "transaction": transaction,
    };
  }
}
