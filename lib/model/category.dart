import 'package:flutter/cupertino.dart';

class Category {
  String olahraga;

  Category(this.olahraga);

  static Category fromDocument(Map<String, dynamic> data) {
    return Category(data['olahraga']);
  }

  static List<Category> fromSnapshot(List categorySnapshot) {
    return categorySnapshot.map((e) {
      return Category.fromDocument(e);
    }).toList();
  }
}
