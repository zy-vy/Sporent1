import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/model/product.dart';
import 'package:sporent/repository/image_repository.dart';
import 'package:sporent/repository/order_repository.dart';
import 'package:sporent/repository/user_repository.dart';

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
    order.product?.imageFile = await imageRepository
        .getImageFile("${Product.imagePath}/${order.product!.img}");
    order.beforePhotoOwner != null? order.beforeOwnerFile = await imageRepository.getImageFile("${Order.conditionCheckPath}/${order.beforePhotoOwner}"):null;
    order.afterPhotoOwner != null? order.afterOwnerFile = await imageRepository.getImageFile("${Order.conditionCheckPath}/${order.afterPhotoOwner}"):null;
    order.beforePhotoUser != null? order.beforeUserFile = await imageRepository.getImageFile("${Order.conditionCheckPath}/${order.beforePhotoUser}"):null;
    order.afterPhotoOwner != null? order.afterUserFile = await imageRepository.getImageFile("${Order.conditionCheckPath}/${order.afterPhotoUser}"):null;
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

  Future<bool> finishOrder(Order order,File afterPhoto, String description) async {
    var name = "${order.id}_owner_after";

    order.status = "DONE";
    order.afterPhotoOwner = "name";
    order.afterOwnerFile = afterPhoto;
    order.description = description;

    var task1 = imageRepository.uploadFile(
        Order.conditionCheckPath, name, afterPhoto);
    var task2 = orderRepository.updateOrder(order);

    return Future.wait([task1, task2])
        .then((value) => true)
        .onError((error, stackTrace) {
      log("$error$stackTrace");
      return false;
    });
    return false;
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
        declineList = <Order>[];
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
      }
    });
    finalList = waitingList +
        confirmList +
        acceptList +
        deliverList +
        activeList +
        returnList +
        doneList;
    return finalList;
  }
}
