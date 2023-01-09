
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sporent/model/cart_detail.dart';
import 'package:sporent/model/payment.dart';
import 'package:sporent/model/user.dart';
import 'package:sporent/repository/cart_repository.dart';
import 'package:sporent/repository/image_repository.dart';
import 'package:sporent/repository/order_repository.dart';

import '../controller/auth_controller.dart';
import '../model/order.dart';

class TransactionViewModel with ChangeNotifier{
  TransactionViewModel._internal();

  static final TransactionViewModel _instance= TransactionViewModel._internal();

  factory TransactionViewModel()=>_instance;

  Order? order;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final orderRepository = OrderRepository();
  final imageRepository = ImageRepository();

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> checkout(CartDetail cartDetail, Order order,UserLocal? user) async {
    isLoading = true;
    bool result = false;


    user ??= await AuthController()
          .getCurrentUser();
    if(user ==null)return false;

var time = DateTime.now();

    var fileName = "${user.id!}_";
    var fileNameKtp = "${fileName}ktp_$time";
    var fileNamePayment = "${fileName}payment_$time";

    order.paymentRef = FirebaseFirestore.instance.doc( Payment.docPath) ;
    order.status="WAITING";
    order.issueDate= time;
    order.ktpImage=fileNameKtp;
    order.paymentImage=fileNamePayment;

    result = await OrderRepository().checkout(order);

    if (!result) {
      debugPrint("+++ checkout : error insert");
      return false;
    }

    imageRepository.uploadFile(Order.ktpPath, fileNameKtp, order.ktpFile!);
    imageRepository.uploadFile(Order.paymentPath, fileNamePayment, order.paymentFile!);

    CartRepository().deleteCart(cartDetail);
    //    remove cart
    isLoading= false;
    return true;
  }


}