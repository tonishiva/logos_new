import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../globals.dart' as globals;

class ReferencesProvider with ChangeNotifier {
  Map<String, dynamic> _references;

  Map<String, dynamic> get references {
    return {..._references};
  }

  Future<void> getReferences(BuildContext context) async {
    final url = globals.baseUrl + 'references';
    Dio dio = Dio();
    final languageCode = EasyLocalization.of(context).locale.languageCode;
    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {"Accept-Language": languageCode},
        ),
      );
      _references = response.data;
      notifyListeners();
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
