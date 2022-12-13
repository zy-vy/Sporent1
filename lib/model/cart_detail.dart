
import 'package:cloud_firestore/cloud_firestore.dart';

class CartDetail{
  static String path="cart_detail";
  String? id;
  DocumentReference? cartRef;
  DocumentReference? productRef;
  int? quantity;
  DateTime? startDate;
  DateTime? endDate;

  CartDetail({this.id,this.cartRef,this.productRef,this.startDate,this.endDate,this.quantity});

  factory CartDetail.fromDocument(String id, Map<String,dynamic> data ){
    return CartDetail(
      id: id,
      cartRef: data['cart'],
      productRef: data['product'],
      quantity: data['quantity'],
      startDate: data['start_date'].toDate(),
      endDate: data['end_date'].toDate(),
    );
  }

  static List<CartDetail> fromSnapshot(List<QueryDocumentSnapshot<Map<String,dynamic>>> snapshot){
    return snapshot.map((e) => CartDetail.fromDocument(e.id,e.data())).toList();
  }

  DocumentReference toReference (){
    var path = "cart_detail/$id";
    return FirebaseFirestore.instance.doc(path);
  }

  Map<String,dynamic> toFirestore(){
    return {
      if(cartRef!=null) 'cart' : cartRef,
      if(productRef != null) 'product': productRef,
      if(quantity != null) 'quantity': quantity,
      if(startDate != null) 'start_date' : startDate,
      if(endDate != null) 'end_date': endDate,
    };
  }

}