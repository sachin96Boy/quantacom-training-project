import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app_quantacom/utils/dio_instance.dart';

class Auth extends ChangeNotifier {
  dynamic _id;
  dynamic _token;

  Auth(this._id, this._token);

  String get userId {
    return _id;
  }

  String get token {
    return _token;
  }

  bool get isAuth {
    return _token != null ? true : false;
  }

  Future<void> handleLogin(
      Map<String, String> initialValues, SharedPreferences prefs) async {
    try {
      final response = await dioInstance.post(
        '/api/v1/auth/signin',
        data: json.encode(initialValues),
      );
      if (response.statusCode == 200) {
        final extractedData = response.data as Map<String, dynamic>;
        await prefs.setString('userName', extractedData['userName']);
        await prefs.setString('userEmail', extractedData['userEmail']);
        await prefs.setString('userType', extractedData['userType']);

        _token = extractedData['token'];
        _id = extractedData['id'];

        notifyListeners();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }
  }

  Future<void> handleLogout(SharedPreferences prefs) async {
    await prefs.remove('userName');
    await prefs.remove('userEmail');
    await prefs.remove('userType');

    _token = null;
    _id = null;

    notifyListeners();
  }
}
