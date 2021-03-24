import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logos_new/providers/auth_provider.dart';
import 'package:logos_new/providers/create_order_provider.dart';
import 'package:logos_new/providers/orders_search_provider.dart';
import 'package:logos_new/providers/sender_orders_provider.dart';
import 'package:logos_new/providers/transporter_orders_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = 'https://logos-dev.huboxt.com/api/';

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

void clearSessionData(BuildContext context) {
  Provider.of<CreateOrderProvider>(context, listen: false).clearData();
  Provider.of<SenderOrdersProvider>(context, listen: false).clearData();
  // Provider.of<AuthProvider>(context, listen: false).clearData();
  Provider.of<TransporterOrdersProvider>(context, listen: false).clearData();
  Provider.of<OrdersSearchProvider>(context, listen: false).clearData();
}
