import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logos_new/models/user_model.dart';
import 'package:logos_new/models/vehicle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class AuthProvider with ChangeNotifier {
  User _user = User();
  Vehicle _vehicle = Vehicle();
  bool _isLoading = false;
  String _phoneRegistrationToken;
  bool _isPhoneVerified = false;
  List<dynamic> _vehicleMakes = [];
  List<dynamic> _vehicleModels = [];
  Map<String, dynamic> _errors = {};
  String _error;
  String _token;
  String _userRole;
  bool _isAuth = false;

  String get userRole {
    return _userRole;
  }

  String get error {
    return _error;
  }

  bool get isAuth {
    return _isAuth;
  }

  void setIsAuth(bool value) {
    _isAuth = value;
    notifyListeners();
  }

  Map<String, dynamic> get errors {
    return {..._errors};
  }

  String get vehicleMake {
    if (_vehicle.make != null) {
      return _vehicle.make['name'];
    } else {
      return null;
    }
  }

  File get licenseFront {
    return _user.driverLicenseFront;
  }

  File get licenseBack {
    return _user.driverLicenseBack;
  }

  File get passportFront {
    return _user.passportFront;
  }

  File get passportBack {
    return _user.passportBack;
  }

  int get vehicleCapacity {
    return _vehicle.kgAbility ?? 500;
  }

  int get vehicleWidth {
    return _vehicle.width;
  }

  int get vehicleLength {
    return _vehicle.length;
  }

  int get vehicleHeight {
    return _vehicle.height;
  }

  String get vehicleModel {
    if (_vehicle.model != null) {
      return _vehicle.model['name'];
    } else {
      return null;
    }
  }

  String get vehicleBodyType {
    if (_vehicle.bodyType != null) {
      return _vehicle.bodyType['label'];
    } else {
      return null;
    }
  }

  String get vehicleLoadingType {
    if (_vehicle.loadingType != null) {
      return _vehicle.loadingType['label'];
    } else {
      return null;
    }
  }

  List<dynamic> get vehicleMakes {
    return [..._vehicleMakes];
  }

  List<dynamic> get vehicleModels {
    return [..._vehicleModels];
  }

  bool get isPhoneVerified {
    return _isPhoneVerified;
  }

  bool get isLoading {
    return _isLoading;
  }

  String get firstName {
    return _user.firstName;
  }

  String get lastName {
    return _user.lastName;
  }

  String get email {
    return _user.email;
  }

  String get phoneNumber {
    return _user.phoneNumber;
  }

  String get role {
    return _user.role;
  }

  String get password {
    return _user.password;
  }

  String get businessType {
    return _user.businessType;
  }

  void clearErrors() {
    _errors = {};
    notifyListeners();
  }

  void setAgreementId(int value) {
    _user.agreementId = value;
    notifyListeners();
  }

  void setLiceseFront(File value) {
    _user.driverLicenseFront = value;
    notifyListeners();
  }

  void setLiceseBack(File value) {
    _user.driverLicenseBack = value;
    notifyListeners();
  }

  void setPassportFront(File value) {
    _user.passportFront = value;
    notifyListeners();
  }

  void setPassportBack(File value) {
    _user.passportBack = value;
    notifyListeners();
  }

  void setVehicleBodyType(Map<String, dynamic> value) {
    _vehicle.bodyType = value;
    notifyListeners();
  }

  void setVehicleCapacity(int value) {
    _vehicle.kgAbility = value;
    notifyListeners();
  }

  void setVehicleWidth(int value) {
    _vehicle.width = value;
    notifyListeners();
  }

  void setVehicleHeight(int value) {
    _vehicle.height = value;
    notifyListeners();
  }

  void setVehicleLength(int value) {
    _vehicle.length = value;
    notifyListeners();
  }

  void setVehicleLoadingType(Map<String, dynamic> value) {
    _vehicle.loadingType = value;
    notifyListeners();
  }

  void setVehicleMakeType(Map<String, dynamic> value) {
    _vehicle.make = value;
    notifyListeners();
  }

  void setVehicleModelType(Map<String, dynamic> value) {
    _vehicle.model = value;
    notifyListeners();
  }

  void clearVehicleParametersStep() {
    _vehicle = Vehicle();
  }

  void clearPhoneVerificationStep() {
    _isPhoneVerified = false;
    _phoneRegistrationToken = null;
    _errors = {};
  }

  void setPassword(String value) {
    _user.password = value;
    notifyListeners();
  }

  void setBusinessType(String value) {
    _user.businessType = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setRole(String value) {
    _user.role = value;
    notifyListeners();
  }

  void setFirstName(String value) {
    _user.firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _user.lastName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _user.email = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _user.phoneNumber = value;
    notifyListeners();
  }

  void clearData() {
    _user = User();
    _vehicle = Vehicle();
    _isLoading = false;
    _phoneRegistrationToken = null;
    _isPhoneVerified = false;
    _errors = {};
    _vehicleMakes = [];
    _errors = {};
  }

  Future<void> registerPhoneNumber({BuildContext context}) async {
    final url = globals.baseUrl + 'user/register/phone';
    _errors = {};
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        url,
        options: Options(
          headers: {
            "Accept-Language": EasyLocalization.of(context).locale.languageCode
          },
        ),
        data: {
          "number": '+38' + _user.phoneNumber,
        },
      );
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      _phoneRegistrationToken = response.data['token'];
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response.statusCode == 422) {
          _errors = error.response.data['errors'];
        }
        print(error.response.statusCode);
        print(error.response.data);
        throw error;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
        throw error;
      }
    }
  }

  Future<void> verifyPhoneNumber({BuildContext context, String pinCode}) async {
    _errors = {};
    final url = globals.baseUrl + 'user/register/phone/verify';
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        url,
        options: Options(
          headers: {
            "Accept-Language": EasyLocalization.of(context).locale.languageCode
          },
        ),
        data: {
          "token": _phoneRegistrationToken,
          "code": pinCode,
        },
      );
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      _isPhoneVerified = response.data['is_verified'];
      notifyListeners();
    } on DioError catch (error) {
      if (error.response.statusCode >= 400 && error.response.statusCode < 500) {
        print(error.response.statusCode);
        print(error.response.data);
        _errors = error.response.data['errors'];
        notifyListeners();
      } else if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
      }
      throw error;
    }
  }

  Future<void> getVehicleMakes() async {
    final url = globals.baseUrl + 'vehicles/makes';
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
      );
      _vehicleMakes = response.data['data'];
      print(response.statusCode);
      print(response.statusMessage);
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
      }
      throw error;
    }
  }

  Future<void> getVehicleModels() async {
    final url =
        globals.baseUrl + 'vehicles/makes/${_vehicle.make['id']}/models';
    Dio dio = Dio();
    try {
      Response response = await dio.get(
        url,
      );
      _vehicleModels = response.data['data'];
      print(response.statusCode);
      print(response.statusMessage);
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
      }
      throw error;
    }
  }

  Future<void> sendRegistrationRequest({
    bool validate = false,
    BuildContext context,
  }) async {
    _errors = {};
    final url = validate
        ? globals.baseUrl + 'user/register?validate_only=1'
        : globals.baseUrl + 'user/register';
    Dio dio = Dio();
    try {
      FormData formData = FormData.fromMap({
        "role": _user.role != null ? _user.role : null,
        "type": _user.businessType != null ? _user.businessType : null,
        "first_name": _user.firstName != null ? _user.firstName : null,
        "last_name": _user.lastName != null ? _user.lastName : null,
        "email": _user.email != null ? _user.email : null,
        "agreement_id": _user.agreementId != null ? _user.agreementId : null,
        "password": _user.password != null ? _user.password : null,
        "password_confirmation": _user.password != null ? _user.password : null,
        "phone": _phoneRegistrationToken,
        "vehicle": _user.role == "sender"
            ? {}
            : {
                "vehicle_model_id":
                    _vehicle.model != null ? _vehicle.model['id'] : null,
                "body_type":
                    _vehicle.bodyType != null ? _vehicle.bodyType['key'] : null,
                "loading_type": _vehicle.loadingType != null
                    ? _vehicle.loadingType['key']
                    : null,
                "body_width": _vehicle.width != null ? _vehicle.width : null,
                "body_height": _vehicle.height != null ? _vehicle.height : null,
                "body_depth": _vehicle.length != null ? _vehicle.length : null,
                "kg_ability":
                    _vehicle.kgAbility != null ? _vehicle.kgAbility : null,
                "document":
                    _user.passportFront != null && _user.passportBack != null
                        ? {
                            "file_id_front": await MultipartFile.fromFile(
                                _user.passportFront.path),
                            "file_id_back": await MultipartFile.fromFile(
                                _user.passportBack.path),
                          }
                        : {},
              },
        "driving_license": _user.driverLicenseFront != null &&
                _user.driverLicenseBack != null
            ? {
                "file_id_front":
                    await MultipartFile.fromFile(_user.driverLicenseFront.path),
                "file_id_back":
                    await MultipartFile.fromFile(_user.driverLicenseBack.path),
              }
            : {}
      });
      print('2');
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Accept-Language': EasyLocalization.of(context).locale.languageCode,
          },
        ),
      );
      print(response.statusCode);
      print(response.data);
      final prefs = await SharedPreferences.getInstance();
      final userToken = json.encode({
        'type': response.data['data']['type'],
        'token': response.data['data']['token'],
      });
      if (prefs.containsKey('userData')) {
        prefs.remove('userData');
      }
      prefs.setString('userData', userToken);
      notifyListeners();
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.data);
        print(error.response.statusMessage);
        _errors = error.response.data['errors'];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
      }
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    } else {
      _isAuth = true;
      notifyListeners();
      return true;
    }
  }

  Future<void> login(
      {String email, String password, BuildContext context}) async {
    _error = '';
    final url = globals.baseUrl + 'user/login';
    Dio dio = Dio();
    try {
      Response response = await dio.post(url,
          options: Options(
            headers: {
              'Accept-Language':
                  EasyLocalization.of(context).locale.languageCode,
            },
          ),
          data: {
            "email": email,
            "password": password,
          });
      final token = response.data['data']['token'];
      final type = response.data['data']['type'];
      print(token);
      final prefs = await SharedPreferences.getInstance();
      final userToken = json.encode({
        'type': type,
        'token': token,
      });
      if (prefs.containsKey('userData')) {
        prefs.remove('userData');
      }
      prefs.setString('userData', userToken);
      _isAuth = true;
      print(response.statusCode);
      print(response.data);
      notifyListeners();
      print(isAuth);
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.data);
        error.response.statusCode > 500
            ? _error = ''
            : _error = error.response.data["message"];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
        _error = '';
      }
      throw error;
    }
  }

  Future<void> logout({BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final url = globals.baseUrl + 'user/logout';
    Dio dio = Dio();

    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Accept-Language': EasyLocalization.of(context).locale.languageCode,
            'Authorization':
                '${extractedUserData['type']} ${extractedUserData['token']}',
          },
        ),
      );
      if (prefs.containsKey('userData')) {
        prefs.remove('userData');
      }
      _isAuth = false;
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      notifyListeners();
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.data);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
      }
      throw error;
    }
  }
}
