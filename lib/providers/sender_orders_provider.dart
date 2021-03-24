import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class SenderOrdersProvider with ChangeNotifier {
  List<dynamic> _pendingOrders = [];
  List<dynamic> _ongoingOrders = [];
  List<dynamic> _archiveOrders = [];
  int _currentTabIndex = 0;
  int _currentPagePending = 1;
  int _currentPageOngoing = 1;
  int _currentPageArchive = 1;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  int get currentTabIndex {
    return _currentTabIndex;
  }

  List<dynamic> get pendingOrders {
    return [..._pendingOrders];
  }

  List<dynamic> get ongoingOrders {
    return [..._ongoingOrders];
  }

  List<dynamic> get archiveOrders {
    return [..._archiveOrders];
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
    _ongoingOrders = [];
    _pendingOrders = [];
    _archiveOrders = [];
    _currentTabIndex = 0;
    _currentPageArchive = 1;
    _currentPageOngoing = 1;
    _currentPagePending = 1;
  }

  Future<void> getPendingOrders({
    BuildContext context,
    bool renew = false,
    bool isFromCombinedRequest = false,
    Map<String, dynamic> initialHeaders,
  }) async {
    if (renew) {
      _pendingOrders = [];
      _currentPagePending = 1;
    }
    Map<String, dynamic> headers = context != null
        ? await globals.getUserCredentials(context)
        : initialHeaders;
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders/sender/opened";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _pendingOrders = response.data['data'];
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

  Future<void> getOngoingOrders({
    BuildContext context,
    bool renew = false,
    bool isFromCombinedRequest = false,
    Map<String, dynamic> initialHeaders,
  }) async {
    if (renew) {
      _ongoingOrders = [];
      _currentPageOngoing = 1;
    }
    Map<String, dynamic> headers = context != null
        ? await globals.getUserCredentials(context)
        : initialHeaders;
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders/sender/active";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _ongoingOrders = response.data['data'];
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

  Future<void> getArchiveOrders({
    BuildContext context,
    bool renew,
    bool isFromCombinedRequest = false,
    Map<String, dynamic> initialHeaders,
  }) async {
    if (renew) {
      _archiveOrders = [];
      _currentPageArchive = 1;
    }
    Map<String, dynamic> headers = context != null
        ? await globals.getUserCredentials(context)
        : initialHeaders;
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders/sender/completed";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _archiveOrders = response.data['data'];
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
      await getPendingOrders(
          isFromCombinedRequest: true,
          context: null,
          renew: true,
          initialHeaders: _headers);
      await getOngoingOrders(
          isFromCombinedRequest: true,
          context: null,
          renew: true,
          initialHeaders: _headers);
      await getArchiveOrders(
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
