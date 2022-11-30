import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/category.dart';

class CategoryRepository {


  // CategoryRepository();
  //

  // final _firestore = FirebaseFirestore.instance;
  final _categoryColl = FirebaseFirestore.instance.collection('category');

  Stream<List<Category>> getCategoryList(){
    return _categoryColl.snapshots().map((snapshot) => Category.fromSnapshot(snapshot.docs));
  }

}