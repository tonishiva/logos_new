import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = 'http://logos-dev.huboxt.com/api/';

Future<Map<String, dynamic>> getUserCredentials(BuildContext context) async {
  Map<String, dynamic> headers = {};
  final prefs = await SharedPreferences.getInstance();
  final extractedUserData =
      json.decode(prefs.getString('userData')) as Map<String, Object>;
  headers['Authorization'] =
      '${extractedUserData['type']} ${extractedUserData['token']}';
  headers['Accept-Language'] = EasyLocalization.of(context).locale.languageCode;
  return headers;
}
