import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class OrdersSearchProvider with ChangeNotifier {
  List<dynamic> _openedOrders = [];
  List<dynamic> _additionalLoadings = [];
  bool _isOrdersSelected = true;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  bool get isOrdersSelected {
    return _isOrdersSelected;
  }

  List<dynamic> get openedOrders {
    return [..._openedOrders];
  }

  List<dynamic> get additionalLoadings {
    return [..._additionalLoadings];
  }

  void setIsOrdersSelected(bool value) {
    _isOrdersSelected = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearData() {
    _openedOrders = [];
    _additionalLoadings = [];
    _isOrdersSelected = true;
    _isLoading = false;
  }

  Future<void> getOpenedOrders({BuildContext context}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders/opened";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _openedOrders = response.data['data'];
      if (_isLoading) {
        _isLoading = false;
      }
      notifyListeners();
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.statusMessage);
        print(error.response.data);
        if (_isLoading) {
          _isLoading = false;
        }
        notifyListeners();
        throw error;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
        if (_isLoading) {
          _isLoading = false;
        }
        notifyListeners();
        throw error;
      }
    } catch (error) {
      print(error);
      if (_isLoading) {
        _isLoading = false;
      }
      notifyListeners();
      throw error;
    }
  }
}
