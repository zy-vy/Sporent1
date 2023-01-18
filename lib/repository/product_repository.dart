import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

class ProductRepository {
  
  final firestore = FirebaseFirestore.instance.collection("product");
  
  Future<Product> getProductById(String productId) async{
    return firestore.doc(productId).get().then((value) => Product.fromDocument(value.id, value.data() as Map<String, dynamic>));
  }
  
  Future<Product> getProductByRef(String productRef) async {
    return FirebaseFirestore.instance.doc(productRef).get().then((value) => Product.fromDocument(value.id, value.data() as Map<String, dynamic>));
  }
}