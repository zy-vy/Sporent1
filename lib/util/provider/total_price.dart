
import 'package:flutter/foundation.dart';

class TotalPriceProvider with ChangeNotifier {
  int _totalPrice = 0;

  get totalPrice => _totalPrice;

  void addToCart (int price){
    _totalPrice += price;
    notifyListeners();
  }


}