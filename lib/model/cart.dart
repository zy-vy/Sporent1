
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/owner.dart';
import 'package:sporent/model/user.dart';

import 'cart_detail.dart';

class Cart{
  static String path = "cart";
  String? id;
  DocumentReference? userRef;
  DocumentReference? ownerRef;
  Owner? owner;
  UserLocal? user;
  int? totalPrice;
  int? itemCount;
  List<CartDetail>? listCartDetail;

  Cart({this.id,this.userRef,this.ownerRef,this.totalPrice,this.itemCount});

  factory Cart.fromDocument(String id, Map<String,dynamic> data ){
    return Cart(
        id: id,
        userRef: data['user'],
        ownerRef: data['owner'],
        totalPrice: data['total_price'],
        itemCount : data['item_count']
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