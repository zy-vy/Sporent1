import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  static String path = "category";
  String? id;
  String? olahraga;

  Category(this.id, this.olahraga);

  static Category fromDocument(String id, Map<String, dynamic> data) {
    return Category( id,data['olahraga']);
  }

  static List<Category> fromSnapshot(List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots) {
    return snapshots.map((e) {
      return Category.fromDocument(e.id,e.data());
    }).toList();
  }
}
