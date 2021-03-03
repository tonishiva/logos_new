import 'package:flutter/material.dart';

class OrdersProvider with ChangeNotifier {
  List<dynamic> _orders = [];
  List<dynamic> _additionalLoadings = [];
  bool _isOrdersSelected = true;

  bool get isOrdersSelected {
    return _isOrdersSelected;
  }

  List<dynamic> get orders {
    return [..._orders];
  }

  List<dynamic> get additionalLoadings {
    return [..._additionalLoadings];
  }

  void setIsOrdersSelected(bool value) {
    _isOrdersSelected = value;
    notifyListeners();
  }
}
