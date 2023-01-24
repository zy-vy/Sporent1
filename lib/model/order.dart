import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/model/user.dart';
import 'dart:io';

class Order {
  static String path= "transaction";
  static String ktpPath = "ktp";
  static String paymentPath= "payment";
  static String conditionCheckPath = "condition-check";
  String? id;
  DocumentReference? userRef;
  DocumentReference? ownerRef;
  DocumentReference? productRef;
  DocumentReference? paymentRef;
  DocumentReference? complainRef;
  int? quantity;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? issueDate;
  String? beforePhotoUser;
  String? afterPhotoUser;
  String? beforePhotoOwner;
  String? afterPhotoOwner;
  String? deliveryLocation;
  String? deliveryMethod;
  String? ktpImage;
  String? paymentImage;
  String? status;
  String? trackingCode;
  String? returnTrackingCode;
  String? description;
  int? total;

  UserLocal? user;
  UserLocal? owner;
  Product? product;

  File? ktpFile;
  File? paymentFile;
  File? beforeOwnerFile;
  File? afterOwnerFile;
  File? beforeUserFile;
  File? afterUserFile;


  Order({
      this.id,
      this.userRef,
      this.ownerRef,
      this.productRef,
      this.paymentRef,
      this.quantity,
      this.startDate,
      this.endDate,
      this.issueDate,
      this.beforePhotoUser,
      this.afterPhotoUser,
      this.beforePhotoOwner,
      this.afterPhotoOwner,
      this.deliveryLocation,
      this.deliveryMethod,
      this.ktpImage,
      this.paymentImage,
      this.status,
      this.trackingCode,
      this.total,
      this.user,
      this.owner,
      this.product,
      this.ktpFile,
      this.paymentFile,
      this.beforeOwnerFile,
      this.afterOwnerFile,
      this.beforeUserFile,
      this.afterUserFile,
      this.returnTrackingCode,
      this.description,
      this.complainRef
  });

  factory Order.fromDocument(String id, Map<String,dynamic> data){
    return Order(
      id: id,
      ownerRef: data['owner'],
      endDate: data['end_date'].toDate(),
      startDate: data['start_date'].toDate(),
      afterPhotoOwner: data['image_after_owner'],
      afterPhotoUser: data['image_after_user'],
      beforePhotoOwner: data['image_before_owner'],
      beforePhotoUser: data['image_before_user'],
      deliveryLocation: data['delivery_location'],
      deliveryMethod: data['delivery_method'],
      issueDate: data['issue_date'].toDate(),
      ktpImage: data['ktp_image'],
      paymentImage: data['payment_image'],
      productRef: data['product'],
      quantity: data['quantity'],
      status: data['status'],
      total: data['total'],
      trackingCode: data['tracking_code_owner'],
      userRef: data['user'],
      paymentRef: data['payment'],
      returnTrackingCode: data["tracking_code_user"],
      description: data["description"],
      complainRef: data["complain"]
    );
  }

  static List<Order> fromSnapshot(List<QueryDocumentSnapshot> snapshot){
    return snapshot.map((document) => Order.fromDocument(document.id,document.data() as Map<String,dynamic>)).toList();
  }

  Map<String,dynamic> toFirestore(){
    return {
      if (userRef!=null) "user" : userRef,
      if (ownerRef!=null) "owner" : ownerRef,
      if (productRef!=null) "product" : productRef,
      if (quantity!=null) "quantity" : quantity,
      if (startDate!=null) "start_date" : startDate,
      if (endDate!=null) "end_date" : endDate,
      if (issueDate!=null) "issue_date" : issueDate,
      if (beforePhotoOwner!=null) "image_before_owner" : beforePhotoOwner,
      if (afterPhotoOwner!=null) "image_after_owner" : afterPhotoOwner,
      if (beforePhotoUser!=null) "image_before_user" : beforePhotoUser,
      if (afterPhotoUser!=null) "image_after_user" : afterPhotoOwner,
      if (deliveryLocation!=null) "delivery_location" : deliveryLocation,
      if (deliveryMethod!=null) "delivery_method" : deliveryMethod,
      if (ktpImage!=null) "ktp_image" : ktpImage,
      if (paymentImage!=null) "payment_image" : paymentImage ,
      if (status!=null) "status" :status ,
      if (trackingCode!=null) "tracking_code_owner" : trackingCode,
      if (total!=null) "total" : total,
      if(paymentRef!=null) "payment" : paymentRef,
      if(returnTrackingCode!=null) "tracking_code_user" : returnTrackingCode,
      if(description!= null) "description" :description,
      if(complainRef!= null) "complain" :complainRef
    };
  }

  DocumentReference toReference(){
    var doc = "$path/$id";
    return FirebaseFirestore.instance.doc(doc);

  }
}