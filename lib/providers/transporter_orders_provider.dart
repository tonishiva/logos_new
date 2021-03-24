import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class TransporterOrdersProvider with ChangeNotifier {
  List<dynamic> _newOrders = [];
  List<dynamic> _activeOrders = [];
  List<dynamic> _completedOrders = [];
  int _currentTabIndex = 0;
  int _currentPageNew = 1;
  int _currentPageActive = 1;
  int _currentPageCompleted = 1;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  int get currentTabIndex {
    return _currentTabIndex;
  }

  List<dynamic> get newOrders {
    return [..._newOrders];
  }

  List<dynamic> get activeOrders {
    return [..._activeOrders];
  }

  List<dynamic> get completedOrders {
    return [..._completedOrders];
  }

  void setTabIndex(int value) {
    _currentTabIndex = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearData() {
    _isLoading = false;
    _activeOrders = [];
    _newOrders = [];
    _completedOrders = [];
    _currentTabIndex = 0;
    _currentPageActive = 1;
    _currentPageCompleted = 1;
    _currentPageNew = 1;
  }

  Future<void> getNewOrders({
    BuildContext context,
    bool renew = false,
    bool isFromCombinedRequest = false,
    Map<String, dynamic> initialHeaders,
  }) async {
    if (renew) {
      _newOrders = [];
      _currentPageNew = 1;
    }
    Map<String, dynamic> headers = context != null
        ? await globals.getUserCredentials(context)
        : initialHeaders;
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders/related";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _newOrders = response.data['data'];
      if (!isFromCombinedRequest) {
        notifyListeners();
      }
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.statusMessage);
        print(error.response.data);
        throw error;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
        throw error;
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getActiveOrders({
    BuildContext context,
    bool renew = false,
    bool isFromCombinedRequest = false,
    Map<String, dynamic> initialHeaders,
  }) async {
    if (renew) {
      _activeOrders = [];
      _currentPageActive = 1;
    }
    Map<String, dynamic> headers = context != null
        ? await globals.getUserCredentials(context)
        : initialHeaders;
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders/transporter/active";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _activeOrders = response.data['data'];
      if (!isFromCombinedRequest) {
        notifyListeners();
      }
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.statusMessage);
        print(error.response.data);
        throw error;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
        throw error;
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getCompletedOrders({
    BuildContext context,
    bool renew,
    bool isFromCombinedRequest = false,
    Map<String, dynamic> initialHeaders,
  }) async {
    if (renew) {
      _completedOrders = [];
      _currentPageCompleted = 1;
    }
    Map<String, dynamic> headers = context != null
        ? await globals.getUserCredentials(context)
        : initialHeaders;
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders/transporter/completed";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _completedOrders = response.data['data'];
      if (!isFromCombinedRequest) {
        notifyListeners();
      }
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.statusMessage);
        print(error.response.data);
        throw error;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
        throw error;
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> getAllLists({BuildContext context}) async {
    final Map<String, dynamic> _headers =
        await globals.getUserCredentials(context);
    try {
      await getNewOrders(
          isFromCombinedRequest: true,
          context: null,
          renew: true,
          initialHeaders: _headers);
      await getActiveOrders(
          isFromCombinedRequest: true,
          context: null,
          renew: true,
          initialHeaders: _headers);
      await getCompletedOrders(
          isFromCombinedRequest: true,
          context: null,
          renew: true,
          initialHeaders: _headers);
      if (_isLoading) {
        _isLoading = false;
      }
      notifyListeners();
    } catch (error) {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }

      print(error);
      throw error;
    }
  }
}
