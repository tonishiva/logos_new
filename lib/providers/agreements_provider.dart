import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;

class AgreementProvider with ChangeNotifier {
  String _latestAgreement;
  int _agreementId;

  int get agreementId {
    return _agreementId;
  }

  String get latestAgreement {
    return _latestAgreement;
  }

  Future<void> getLatestAgreement() async {
    final url = globals.baseUrl + 'agreements/latest';
    Dio dio = Dio();

    try {
      Response response = await dio.get(url);
      _latestAgreement = response.data['data']['translated_text'];
      _agreementId = response.data['data']['id'];
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
}
