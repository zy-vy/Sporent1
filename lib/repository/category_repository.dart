import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/category.dart';

class CategoryRepository {


  CategoryRepository();
  //

  // final _firestore = FirebaseFirestore.instance;

  Stream<List<Category>> getCategoryList(){
    var categoryColl = FirebaseFirestore.instance.collection('category');
    return categoryColl.snapshots().map((snapshot) => Category.fromSnapshot(snapshot.docs));
  }

}