
import 'package:flutter/foundation.dart';

class ItemCountProvider with ChangeNotifier {
  int _itemCount = 0;

  get itemCount => _itemCount;

  void addToCart (){
    _itemCount += 1;
    notifyListeners();
  }

}