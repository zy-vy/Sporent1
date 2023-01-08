import 'dart:developer';

import 'package:flutter/foundation.dart';

class CartNotifier extends ChangeNotifier {
  bool _listenableValue = false;
  bool get listenableValue => _listenableValue;


  CartNotifier();

  void setValue(){
    _listenableValue = !_listenableValue;
    log("+++ notify");
    notifyListeners();
  }

}