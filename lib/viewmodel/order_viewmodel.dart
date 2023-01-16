import 'package:flutter/foundation.dart';
import 'package:sporent/model/order.dart';
import 'package:sporent/repository/image_repository.dart';
import 'package:sporent/repository/order_repository.dart';

class OrderViewModel with ChangeNotifier{

  Order? order;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final orderRepository = OrderRepository();
  final imageRepository = ImageRepository();

  List<Order>? orderList;

  OrderViewModel();

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Stream<List<Order>?> getAllOrderByOwner(String ownerId){
    return orderRepository.getAllOrderByOwner(ownerId).map((event) {
      orderList = event;
      return orderList;
    });

  }

}