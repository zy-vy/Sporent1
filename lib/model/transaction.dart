import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporent/model/abstract_model.dart';

class TransactionModel {
  String? id;
  DateTime? start_date;
  DateTime? end_date;
  DateTime? issue_date;
  String? status;
  int? total;
  int? quantity;
  String? ktp_image;
  String? payment_image;
  String? delivery_location;
  String? delivery_method;
  String? tracking_code_user;
  String? tracking_code_owner;
  String? image_before_user;
  String? image_after_user;
  String? image_before_owner;
  String? image_after_owner;
  String? description_before_user;
  String? description_after_owner;
  DocumentReference<Map<String, dynamic>>? owner;
  DocumentReference<Map<String, dynamic>>? user;
  DocumentReference<Map<String, dynamic>>? product;
  DocumentReference<Map<String, dynamic>>? complain;

  TransactionModel(
      {this.id,
      this.start_date,
      this.end_date,
      this.issue_date,
      this.status,
      this.total,
      this.quantity,
      this.ktp_image,
      this.payment_image,
      this.delivery_location,
      this.delivery_method,
      this.tracking_code_user,
      this.tracking_code_owner,
      this.image_before_user,
      this.image_after_user,
      this.image_before_owner,
      this.image_after_owner,
      this.description_before_user,
      this.description_after_owner,
      this.owner,
      this.user,
      this.product,
      this.complain});

  static TransactionModel fromDocument(String id, Map<String, dynamic> json) {
    return TransactionModel(
        id: id,
        start_date: json['start_date'].toDate(),
        end_date: json['end_date'].toDate(),
        issue_date: json['issue_date'].toDate(),
        status: json['status'],
        total: json['total'],
        quantity: json['quantity'],
        ktp_image: json['ktp_image'],
        payment_image: json['payment_image'],
        delivery_location: json['delivery_location'],
        delivery_method: json['delivery_method'],
        tracking_code_user: json['tracking_code_user'],
        tracking_code_owner: json['tracking_code_owner'],
        image_before_user: json['image_before_user'],
        image_after_user: json['image_after_user'],
        image_before_owner: json['image_before_owner'],
        image_after_owner: json['image_after_owner'],
        description_before_user: json['description_before_user'],
        description_after_owner: json['description_after_owner'],
        owner: json['owner'],
        user: json['user'],
        product: json['product'],
        complain: json['complain']);
  }

  static List<TransactionModel> fromSnapshot(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) => fromDocument(e.id, e.data())).toList();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": start_date,
        "end_date": end_date,
        "issue_date": issue_date,
        "status": status,
        "total": total,
        "quantity": quantity,
        "ktp_image": ktp_image,
        "payment_image": payment_image,
        "delivery_location": delivery_location,
        "delivery_method": delivery_method,
        "tracking_code_user": tracking_code_user,
        "tracking_code_owner" : tracking_code_owner,
        "image_before_user": image_before_user,
        "image_after_user": image_after_user,
        "image_before_owner": image_before_owner,
        "image_after_owner": image_after_owner,
        "description_before_user": description_before_user,
        "description_after_owner": description_after_owner,
        "owner": owner,
        "user": user,
        "product": product,
        "complain" : complain
      };
}
