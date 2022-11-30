import 'package:cloud_firestore/cloud_firestore.dart';

class Subcategory {

  String type;

  Subcategory(this.type);

  static Subcategory fromDocument(Map<String, dynamic> doc){
    return Subcategory(doc['type']);
  }

  static List<Subcategory> fromSnapshot (List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshots){
    return snapshots.map((snapshot) =>fromDocument(snapshot.data()) ).toList();
  }
}