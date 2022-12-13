
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/owner.dart';

class Cart{
  static String path = "cart";
  String? id;
  DocumentReference? userRef;
  DocumentReference? ownerRef;
  Owner? owner;

  Cart({this.id,this.userRef,this.ownerRef});

  factory Cart.fromDocument(String id, Map<String,dynamic> data ){
    return Cart(
        id: id,
        userRef: data['user'],
        ownerRef: data['owner']
    );
  }

  static List<Cart> fromSnapshot(List<QueryDocumentSnapshot<Map<String,dynamic>>> snapshot){
    return snapshot.map((e) => Cart.fromDocument(e.id,e.data())).toList();
  }

  DocumentReference toReference (){
    var path = "cart/$id";
    return FirebaseFirestore.instance.doc(path);
  }

  Map<String,dynamic> toFirestore(){
    return {
      if(userRef!=null) 'user' : userRef,
      if(ownerRef != null) 'owner' : ownerRef
    };
  }


}