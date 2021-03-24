import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logos_new/models/order_model.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import '../globals.dart' as globals;

class CreateOrderProvider with ChangeNotifier {
  Order _order = Order();
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  DateTime _temporarySelectedDate;

  DateTime get temporarySelectedDate {
    return _temporarySelectedDate;
  }

  String get senderName {
    return _order.senderName;
  }

  String get senderSurname {
    return _order.senderSurname;
  }

  String get senderPhone {
    return _order.senderPhone;
  }

  String get receiverName {
    return _order.receiverName;
  }

  String get receiverSurname {
    return _order.receiverSurname;
  }

  String get receiverPhone {
    return _order.receiverPhone;
  }

  bool get useSenderCredentials {
    return _order.useSenderCredentials;
  }

  bool get useReceiverCredentials {
    return _order.useReceiverCredentials;
  }

  String get originAddress {
    return _order.originAddress;
  }

  String get destinationAddress {
    return _order.destinationAddress;
  }

  double get latFrom {
    return _order.latFrom;
  }

  double get latTo {
    return _order.latTo;
  }

  double get lonFrom {
    return _order.lonFrom;
  }

  double get lonTo {
    return _order.lonTo;
  }

  DateTime get arrivalBefore {
    return _order.arrivalBefore;
  }

  String get packgeDescription {
    return _order.packageDescription;
  }

  String get packageType {
    return _order.packageType;
  }

  double get packageWidth {
    return _order.packageWidth;
  }

  double get packageHeight {
    return _order.packageHeight;
  }

  double get packageLength {
    return _order.packageLength;
  }

  double get packageWeight {
    return _order.packageWeight;
  }

  DateTime get departureAt {
    return _order.departureAt;
  }

  void setSenderName(String value) {
    _order.senderName = value;
    notifyListeners();
  }

  void setSenderSurname(String value) {
    _order.senderSurname = value;
    notifyListeners();
  }

  void setSenderPhone(String value) {
    _order.senderPhone = value;
    notifyListeners();
  }

  void setReceiverName(String value) {
    _order.receiverName = value;
    notifyListeners();
  }

  void setReceiverSurname(String value) {
    _order.receiverSurname = value;
    notifyListeners();
  }

  void setReceiverPhone(String value) {
    _order.receiverPhone = value;
    notifyListeners();
  }

  void setUseSenderCredentials(bool value) {
    _order.useSenderCredentials = value;
    notifyListeners();
  }

  void setUseReceiverCredentials(bool value) {
    _order.useReceiverCredentials = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setTemporarySelectedDate(DateTime value) {
    _temporarySelectedDate = value;
    notifyListeners();
  }

  void setLatFrom(double value) {
    _order.latFrom = value;
    notifyListeners();
  }

  void setLatTo(double value) {
    _order.latTo = value;
    notifyListeners();
  }

  void setLonFrom(double value) {
    _order.lonFrom = value;
    notifyListeners();
  }

  void setLonTo(double value) {
    _order.lonTo = value;
    notifyListeners();
  }

  void setArrivalBefore(DateTime value) {
    _order.arrivalBefore = value;
    notifyListeners();
  }

  void setDepartureAt(DateTime value) {
    _order.departureAt = value;
    notifyListeners();
  }

  void setPackageDescription(String value) {
    _order.packageDescription = value;
    notifyListeners();
  }

  void setPackageType(String value) {
    _order.packageType = value;
    notifyListeners();
  }

  void setOriginAddress(String value) {
    _order.originAddress = value;
    notifyListeners();
  }

  void setDestinationAddress(String value) {
    _order.destinationAddress = value;
    notifyListeners();
  }

  void setPackageWidth(double value) {
    _order.packageWidth = value;
    notifyListeners();
  }

  void setPackageWeight(double value) {
    _order.packageWeight = value;
    notifyListeners();
  }

  void setPackageHeight(double value) {
    _order.packageHeight = value;
    notifyListeners();
  }

  void setPackageLength(double value) {
    _order.packageLength = value;
    notifyListeners();
  }

  void clearData({bool notify = false}) {
    _isLoading = false;
    _order = Order();
    _temporarySelectedDate = null;
    if (notify) {
      notifyListeners();
    }
  }

  Future<void> createOrder({BuildContext context}) async {
    Map<String, dynamic> headers = await globals.getUserCredentials(context);
    if (!headers.containsKey('Authorization')) {
      return false;
    }

    final url = globals.baseUrl + "orders";
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        url,
        options: Options(headers: headers),
        data: {
          "lat_from": _order.latFrom,
          "lon_from": _order.lonFrom,
          "lat_to": _order.latTo,
          "lon_to": _order.lonTo,
          "arrival_before":
              '${DateFormat('y-MM-dd HH:mm:ss', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.arrivalBefore)}',
          "package_description": "Beer",
          "order_description": "",
          "package_type": _order.packageType,
          "package_width": _order.packageWidth,
          "package_height": _order.packageHeight,
          "package_depth": _order.packageLength,
          "package_weight": _order.packageWeight,
          "departure_at":
              '${DateFormat('y-MM-dd HH:mm:ss', EasyLocalization.of(context).locale.toLanguageTag()).format(_order.departureAt)}',
          "use_sender_credentials": _order.useSenderCredentials,
          "sender_cred_name": _order.senderName,
          "sender_cred_surname": _order.senderSurname,
          "sender_cred_phone": '+38' + _order.senderPhone,
          "use_receiver_credentials": _order.useReceiverCredentials,
          "receiver_cred_name": _order.receiverName,
          "receiver_cred_surname": _order.receiverSurname,
          "receiver_cred_phone": '+38' + _order.receiverPhone,
        },
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
