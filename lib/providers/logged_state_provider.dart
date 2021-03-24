import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedStateProvider with ChangeNotifier {
  bool _isAuth = false;

  bool get isAuth {
    print('From get isAuth');
    return _isAuth;
  }

  void setIsAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print('false autologin');
      return false;
    } else {
      print('true autologin');
      _isAuth = true;
      notifyListeners();
      return true;
    }
  }
}
