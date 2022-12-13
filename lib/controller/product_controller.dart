import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/product.dart';

class ProductController {

  final firestore = FirebaseFirestore.instance;

  Future<Product?> getProduct (String productRef) async {
    return firestore.doc(productRef).get().then((value) => Product.fromDocument(value.id, value.data()!));
  }
}