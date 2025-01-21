import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transfer/models/login_response.dart';
import 'package:transfer/utils/constant_strings.dart';
import 'package:transfer/utils/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  LoginResponse? _loginResponse;
  final LocalStorage _localStorage = LocalStorage();

  Future<http.Response?> getLogin(
      {required String email, required String password}) async {
    try {
      http.Response response = await http.post(Uri.parse(baseUrl + loginEp),
          body: {"email": email, "password": password});

      if (response.statusCode == 200) {
        _loginResponse =
            LoginResponse.fromJson(jsonDecode(response.body)["data"]);
        String token = _loginResponse?.token?.accessToken ?? "";
        _localStorage.setToken(token);
      }
      notifyListeners();

      return response;
    } catch (e) {
      log("Login error - $e");
      return null;
    }
  }

  Future<http.Response?> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      String token = _localStorage.token;
      http.Response response = await http.post(
        Uri.parse(baseUrl + changePasswordEp),
        body: {
          "current_password": currentPassword,
          "password": newPassword,
          "password_confirmation": newPassword
        },
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (e) {
      log("Login error - $e");
      return null;
    }
  }
}
