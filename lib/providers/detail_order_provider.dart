import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import '../globals.dart' as globals;

class DetailOrderProvider with ChangeNotifier {
  Map<String, dynamic> _order = {};
  bool _isLoading = false;
  List<LatLng> _routePoints = [];
  bool _isButtonLoading = false;

  List<LatLng> get routePoints {
    return [..._routePoints];
  }

  bool get isLoading {
    return _isLoading;
  }

  bool get isButtonLoading {
    return _isButtonLoading;
  }

  Map<String, dynamic> get order {
    return {..._order};
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsButtonLoading(bool value) {
    _isButtonLoading = value;
    notifyListeners();
  }

  void clearData() {
    _isLoading = false;
    _isButtonLoading = false;
    _order = {};
  }

  Future<void> getOrder({BuildContext context, int orderId}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    var url = globals.baseUrl + "orders/$orderId";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      _order = response.data['data'];
      _order.forEach((key, value) {
        print('$key: $value');
      });
      await getRoutePoints(context: context);
      if (_isLoading) {
        _isLoading = false;
      }
      notifyListeners();
    } on DioError catch (error) {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
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

  Future<void> getRoutePoints({BuildContext context}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl +
        "geo/route/driving/${_order['general']['markers']['from']['lat']}/${_order['general']['markers']['from']['lon']}/${_order['general']['markers']['to']['lat']}/${_order['general']['markers']['to']['lon']}";
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
      List<dynamic> loadedRoute =
          response.data['routes'][0]['geometry']['coordinates'];
      _routePoints = loadedRoute.map((e) => LatLng(e[1], e[0])).toList();
      notifyListeners();
    } on DioError catch (error) {
      if (_isLoading) {
        _isLoading = false;
        notifyListeners();
      }
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

  Future<void> acceptOrder(
      {@required BuildContext context, @required int vehicleId}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    var url = globals.baseUrl + "orders/${_order['id']}/accept";
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        url,
        data: {"user_vehicle_id": vehicleId},
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
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

  Future<void> cancelOrder({@required BuildContext context}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    var url = globals.baseUrl + "orders/${_order['id']}/cancel";
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
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

  Future<void> dropDriver({@required BuildContext context}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    var url = globals.baseUrl + "orders/${_order['id']}/drop";
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
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

  Future<void> finishOrder({@required BuildContext context}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    var url = globals.baseUrl + "orders/${_order['id']}/finish";
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        url,
        options: Options(headers: headers),
      );
      print(response.statusCode);
      print(response.data);
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
}
