import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class GeoProvider with ChangeNotifier {
  Map<String, dynamic> _point = {};
  Map<String, String> _headers = {};
  List<dynamic> _autocompleteList = [];

  Map<String, dynamic> get point {
    return {..._point};
  }

  void addPoint(Map<String, dynamic> value) {
    _point = value;
    notifyListeners();
  }

  List<dynamic> get autocompleteList {
    return [..._autocompleteList];
  }

  void clearAutocompleteList() {
    _autocompleteList = [];
    notifyListeners();
  }

  void clearData() {
    _autocompleteList = [];
  }

  Future<void> getUserCredentials(BuildContext context) async {
    _headers.remove('Authorization');
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _headers['Authorization'] =
        '${extractedUserData['type']} ${extractedUserData['token']}';
    _headers['Accept-Language'] =
        EasyLocalization.of(context).locale.languageCode;
  }

  Future<void> getAutocompleteList(
      {BuildContext context, String location}) async {
    _autocompleteList = [];
    await getUserCredentials(context);
    if (!_headers.containsKey('Authorization')) {
      return false;
    }
    
    final url = globals.baseUrl +
        "geo/autocomplete?q=$location&addressdetails=1&countrycodes=ua";
    Dio dio = Dio();
    try {
      Response response =
          await dio.get(url, options: Options(headers: _headers));
      print(response.statusCode);
      print(response.data);
      List<dynamic> loadedLocations = response.data;
      loadedLocations.forEach((element) {
        _autocompleteList.add({
          'display_name': element['display_name'],
          'boundingbox': element['boundingbox'],
          'marker': {
            'latitude': element['lat'],
            'longitude': element['lon'],
          },
        });
      });
      print(_autocompleteList);
      notifyListeners();
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.statusMessage);
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

  // Future<void> getPlace({double latitude, double longitude}) async {
  //   await getLocale();
  //   await getUserCredentials();
  //   if (!_headers.containsKey('Authorization')) {
  //     return false;
  //   }
  //   final url = 'http://5.189.181.193/api/geo/marker/$latitude/$longitude';
  //   Dio dio = Dio();
  //   try {
  //     Response response =
  //         await dio.get(url, options: Options(headers: _headers));
  //     print(response.statusCode);
  //     print(response.data);
  //     _point = response.data['data'];
  //     notifyListeners();
  //   } on DioError catch (error) {
  //     if (error.response != null) {
  //       print(error.response.statusCode);
  //       print(error.response.statusMessage);
  //     } else {
  //       // Something happened in setting up or sending the request that triggered an Error
  //       print(error.request);
  //       print(error.message);
  //     }
  //     throw error;
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }
}
