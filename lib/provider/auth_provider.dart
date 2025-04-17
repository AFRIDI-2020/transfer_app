import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transfer/models/login_response.dart';
import 'package:transfer/utils/constant_strings.dart';
import 'package:transfer/utils/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  LoginResponse? _loginResponse;
  final LocalStorage _localStorage = LocalStorage();

  LoginResponse? get loginResponse => _loginResponse;
  Original? userInfo;

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

  Future<http.Response?> getRefreshToken() async {
    try {
      http.Response response =
          await http.post(Uri.parse(baseUrl + refreshTokenEp), body: {
        "token": "Bearer ${_localStorage.token}",
      });

      if (response.statusCode == 200) {
        Token token = Token.fromJson(jsonDecode(response.body)["data"]);
        String accessToken = token.accessToken ?? "";
        _localStorage.setToken(accessToken);
      }
      notifyListeners();

      return response;
    } catch (e) {
      log("refresh token error - $e");
      return null;
    }
  }

  Future<http.Response?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response =
          await http.post(Uri.parse(baseUrl + registerEp), body: {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
        "remember": "on"
      });

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

  Future<http.Response?> getCurrentUserInfo() async {
    try {
      String token = _localStorage.token;
      http.Response response = await http.get(
        Uri.parse(baseUrl + userEp),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        userInfo = Original.fromJson(jsonDecode(response.body));
        if (kDebugMode) {
          log("Current user: ${userInfo.toString()}");
        }
      }

      if (response.statusCode == 401) {
        var result = await getRefreshToken();
        if (result?.statusCode == 200) {
          await getCurrentUserInfo();
        } else {
          _localStorage.removeSession();
        }
      }
      notifyListeners();
      return response;
    } catch (e) {
      log("Getting user info error - $e");
      return null;
    }
  }

  Future<http.Response?> sendForgotPasswordRequest(
      {required String email}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(baseUrl + forgotPasswordEp),
        body: {
          "email": email,
        },
      );
      return response;
    } catch (e) {
      log("sending forgot password info error - $e");
      return null;
    }
  }
}
