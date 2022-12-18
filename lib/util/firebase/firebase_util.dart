import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtil {
  static final firestore = FirebaseFirestore.instance;

  static Future<DocumentReference<dynamic>?> getDocumentRef(String path) async {
    return firestore.doc(path);
  }
}