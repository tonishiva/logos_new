import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _user = {};
  List<dynamic> _userVehicles = [];

  Map<String, dynamic> get user {
    return {..._user};
  }

  List<dynamic> get userVehicles {
    return [..._userVehicles];
  }

  Future<void> getUser({BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    var url = globals.baseUrl + 'user';
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
      _user = response.data['data'];
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
      url = globals.baseUrl + 'user/vehicles';
      response = await dio.get(
        url,
        options: Options(
          headers: {
            'Accept-Language': EasyLocalization.of(context).locale.languageCode,
            'Authorization':
                '${extractedUserData['type']} ${extractedUserData['token']}',
          },
        ),
      );
      _userVehicles = response.data['data'];
      print(response.statusCode);
      print(response.statusMessage);
      print(response.data);
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
