import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/repository/image_repository.dart';
import 'package:sporent/repository/order_repository.dart';
import 'package:sporent/repository/user_repository.dart';

import '../model/balance.dart';
import '../model/deposit.dart';
import '../repository/product_repository.dart';

class OrderViewModel with ChangeNotifier {
  Order? order;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final orderRepository = OrderRepository();
  final imageRepository = ImageRepository();

  List<Order>? _orderList;

  List<Order>? get orderList => _orderList;

  set orderList(List<Order>? value) {
    _orderList = value;
  }

  OrderViewModel._internal();

  static final OrderViewModel _instance = OrderViewModel._internal();

  factory OrderViewModel() {
    return _instance;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Stream<List<Order>?> getAllOrderByOwner(String ownerId) {
    return orderRepository.getAllOrderByOwner(ownerId).map((event) {
      orderList = arrangeData(event);
      return orderList;
    });
  }

  @Deprecated("not used")
  Future<void> fetch() async {
    // isLoading=true;
    _orderList?.forEach((order) async {
      order.user = await UserRepository().getUserByRef(order.userRef!.path);
      order.product =
          await ProductRepository().getProductByRef(order.productRef!.path);
      // log("+++ name ${order.product?.name}");
      order.product?.imageFile = await ImageRepository()
          .getImageFile("${Product.imagePath}/${order.product!.img}");
      // isLoading = false;
    });
  }

  Future<Order> fetchData(Order order) async {
    order.user = await UserRepository().getUserByRef(order.userRef!.path);
    order.product =
        await ProductRepository().getProductByRef(order.productRef!.path);
    // order.product?.imageFile = await imageRepository
    //     .getImageFile("${Product.imagePath}/${order.product!.img}");
    order.beforePhotoOwner != null
        ? order.beforeOwnerFile = await imageRepository.getImageFile(
            "${Order.conditionCheckPath}/${order.beforePhotoOwner}")
        : null;
    order.afterPhotoOwner != null
        ? order.afterOwnerFile = await imageRepository.getImageFile(
            "${Order.conditionCheckPath}/${order.afterPhotoOwner}")
        : null;
    order.beforePhotoUser != null
        ? order.beforeUserFile = await imageRepository.getImageFile(
            "${Order.conditionCheckPath}/${order.beforePhotoUser}")
        : null;
    order.afterPhotoUser != null
        ? order.afterUserFile = await imageRepository
            .getImageFile("${Order.conditionCheckPath}/${order.afterPhotoUser}")
        : null;
    return order;
  }

  Future<bool> acceptOrder(Order order) async {
    order.status = "ACCEPT";
    return orderRepository.updateOrder(order);
  }

  Future<bool> declineOrder(Order order) async {
    order.status = "DECLINE";
    return orderRepository.updateOrder(order);
  }

  Future<bool> submitOrder(
      Order order, File? beforeImage, String trackingLink) async {
    order.status = "DELIVER";
    var name = "${order.id}_owner_before";

    order.trackingCode = trackingLink;
    order.beforePhotoOwner = name;
    order.beforeOwnerFile = beforeImage;

    var task1 = imageRepository.uploadFile(
        Order.conditionCheckPath, name, beforeImage!);
    var task2 = orderRepository.updateOrder(order);

    return Future.wait([task1, task2])
        .then((value) => true)
        .onError((error, stackTrace) {
      log("$error$stackTrace");
      return false;
    });
  }

  Future<bool> finishOrder(
      Order order, File afterPhoto, String description) async {
    var name = "${order.id}_owner_after";

    order.status = "DONE";
    order.afterOwnerFile = afterPhoto;
    order.description = description;

    var userRef = order.userRef;
    var ownerRef = order.ownerRef;

    await FirebaseFirestore.instance.doc(userRef!.path).update({
      "deposit": FieldValue.increment(order.deposit!)
    }).onError((error, stackTrace) => log("error deposit"));
    await FirebaseFirestore.instance.doc(ownerRef!.path).update({
      "owner_balance":
          FieldValue.increment(order.balance!)
    }).onError((error, stackTrace) => log("error balance"));

    var deposit = Deposit(
            amount: order.deposit,
            date: DateTime.now(),
            detail_id: FirebaseFirestore.instance
                .collection("transaction")
                .doc(order.id),
            user: FirebaseFirestore.instance
                .collection("user")
                .doc(order.user!.id),
            status: "plus")
        .toJson();

    var depositRef = FirebaseFirestore.instance.collection("deposit").doc();

    await depositRef.set(deposit);

    var balance = Balance(
            amount: order.balance,
            date: DateTime.now(),
            detail_id: FirebaseFirestore.instance
                .collection("transaction")
                .doc(order.id),
            owner: FirebaseFirestore.instance
                .collection("user")
                .doc(order.owner!.id),
            status: "plus")
        .toJson();

    var balanceRef = FirebaseFirestore.instance.collection("balance").doc();
    
    await balanceRef.set(balance);

    var task1 =
        imageRepository.uploadFile(Order.conditionCheckPath, name, afterPhoto);
    var task2 = orderRepository.updateOrder(order);

    return Future.wait([task1, task2])
        .then((value) => true)
        .onError((error, stackTrace) {
      log("$error$stackTrace");
      return false;
    });
    return false;
  }

  Future<bool> acceptPayment(Order order) async {
    order.status = "CONFIRM";
    return orderRepository.updateOrder(order);
  }

  Future<bool> rejectPayment(Order order) async {
    order.status = "REJECT";
    return orderRepository.updateOrder(order);
  }

  List<Order> arrangeData(List<Order>? orderList) {
    List<Order> finalList = <Order>[],
        waitingList = <Order>[],
        confirmList = <Order>[],
        acceptList = <Order>[],
        deliverList = <Order>[],
        activeList = <Order>[],
        returnList = <Order>[],
        doneList = <Order>[],
        declineList = <Order>[],
        rejectList = <Order>[],
        complainList = <Order>[];
    orderList?.forEach((order) {
      var status = order.status ?? "";
      switch (status) {
        case "WAITING":
          waitingList.add(order);
          break;
        case "CONFIRM":
          confirmList.add(order);
          break;
        case "ACCEPT":
          acceptList.add(order);
          break;
        case "DELIVER":
          deliverList.add(order);
          break;
        case "ACTIVE":
          activeList.add(order);
          break;
        case "RETURN":
          returnList.add(order);
          break;
        case "DONE":
          doneList.add(order);
          break;
        case "DECLINE":
          declineList.add(order);
          break;
        case "REJECT":
          rejectList.add(order);
          break;
        case "COMPLAIN":
          confirmList.add(order);
          break;
      }
    });
    finalList =
        // waitingList +
        complainList +
            confirmList +
            acceptList +
            deliverList +
            activeList +
            returnList +
            declineList +
            rejectList +
            doneList;
    return finalList;
  }
}
