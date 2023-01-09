import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:sporent/model/cart_detail.dart';
import 'package:sporent/repository/cart_repository.dart';

import '../model/cart.dart';

class CartViewModel with ChangeNotifier {

  bool _isLoading = true;

  List<Cart>? _listCart ;

  late int _totalAmount ;

  List<Cart>? get listCart => _listCart;

  int get totalAmount => _totalAmount;

  final _repository = CartRepository();

  set listCart ( List<Cart>? list){
    _listCart = list;
    notifyListeners();
  }

  CartViewModel(){
    fetchData();
  }

  bool get isLoading{
    // notifyListeners();
    return _isLoading;
  }

  void set isLoading(bool value){
    _isLoading = value;
    // notifyListeners();
  }

  Future<void> fetchData ( )async{
    try{
      isLoading = true;
      _totalAmount = 0;
      _listCart= await _repository.getCartList().then((value) {
        value?.forEach((cart) {
          _totalAmount += cart.totalPrice??0;
        });
        return value;
      });
    }catch(e){
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<List<CartDetail?>> getCartDetailList(Cart cart) async {
    return _repository.getCartDetailList(cart);
  }


  Future<void> removeCart (CartDetail cartDetail) async {
    isLoading = true;
    _repository.deleteCart(cartDetail);
    log("notify");
    fetchData();
    notifyListeners();
  }

}