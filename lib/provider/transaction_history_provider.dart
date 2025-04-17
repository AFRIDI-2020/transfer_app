import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:transfer/models/transaction_history_item_model.dart';
import 'package:http/http.dart' as http;
import 'package:transfer/provider/auth_provider.dart';
import 'package:transfer/utils/local_storage.dart';

import '../utils/constant_strings.dart';

class TransactionHistoryProvider extends ChangeNotifier {
  final LocalStorage _localStorage = LocalStorage();
  final AuthProvider authProvider;

  TransactionHistoryProvider({required this.authProvider});

  final List<TransactionHistoryItemModel> _transactionList = [];

  List<TransactionHistoryItemModel> get transactionList => _transactionList;

  Future<http.Response?> getTransactionHistory() async {
    _transactionList.clear();
    try {
      String token = _localStorage.token;
      http.Response response = await http.get(
        Uri.parse(baseUrl + transactionListEp),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)["data"];
        data.forEach((json) {
          TransactionHistoryItemModel transactionHistoryItemModel =
              TransactionHistoryItemModel.fromJson(json);
          _transactionList.add(transactionHistoryItemModel);
        });
      }

      if (response.statusCode == 401) {
        var result = await authProvider.getRefreshToken();
        if (result?.statusCode == 200) {
          await getTransactionHistory();
        } else {
          _localStorage.removeSession();
        }
      }

      notifyListeners();

      return response;
    } catch (e) {
      log("Getting transaction list error - $e");
      return null;
    }
  }
}
