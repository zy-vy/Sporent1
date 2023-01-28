import 'package:cloud_firestore/cloud_firestore.dart';

class ComplainDetail {
  final String? id;
  final DateTime? date;
  final DocumentReference? complain;
  final String? description;
  final List<dynamic>? image;

  const ComplainDetail(
      {this.id,
      this.date,
      this.complain,
      this.description,
      this.image});

  static ComplainDetail fromDocument(String id, Map<String, dynamic> json) {
    return ComplainDetail(
      id: id,
      date: json['date'].toDate(),
      complain: json['complain'],
      description: json['description'],
      image: json['image']
    );
  }

  static ComplainDetail fromDocumentNoImage(String id, Map<String, dynamic> json) {
    return ComplainDetail(
      id: id,
      date: json['date'].toDate(),
      complain: json['complain'],
      description: json['description'],
    );
  }
  
  toJSON() {
    return {
      "date" : date,
      "complain": complain,
      "description": description,
      "image": image
    };
  }
}
