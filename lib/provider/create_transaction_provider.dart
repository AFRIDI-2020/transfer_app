import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:transfer/models/receiver.dart';
import 'package:transfer/models/transaction_create_info.dart';
import 'package:http/http.dart' as http;
import '../models/payment_request.dart';
import '../utils/constant_strings.dart';
import '../utils/local_storage.dart';

class CreateTransactionProvider extends ChangeNotifier {
  final LocalStorage _localStorage = LocalStorage();

  TransactionCreateInfo? _transactionCreateInfo;
  Receiver? _selectedSendingMethod;
  Receiver? _selectedReceivingMethod;
  DateTime? _transactionDate;
  TimeOfDay? _transactionTime;

  TransactionCreateInfo? get transactionCreateInfo => _transactionCreateInfo;

  Receiver? get selectedSendingMethod => _selectedSendingMethod;

  Receiver? get selectedReceivingMethod => _selectedReceivingMethod;

  DateTime? get transactionDate => _transactionDate;

  TimeOfDay? get transactionTime => _transactionTime;

  void selectTransactionDate(DateTime date) {
    _transactionDate = date;
    notifyListeners();
  }

  void selectTransactionTime(TimeOfDay time) {
    _transactionTime = time;
    notifyListeners();
  }

  void selectSendingMethod(Receiver method) {
    _selectedSendingMethod = method;
    notifyListeners();
  }

  void selectReceivingMethod(Receiver method) {
    _selectedReceivingMethod = method;
    notifyListeners();
  }

  Future<http.Response?> getTransactionCreateInfo() async {
    try {
      String token = _localStorage.token;
      http.Response response = await http.get(
        Uri.parse(baseUrl + transactionCreateEp),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)["data"];
        _transactionCreateInfo = TransactionCreateInfo.fromJson(data);
      }
      notifyListeners();

      return response;
    } catch (e) {
      log("transaction create info error - $e");
      return null;
    }
  }

  double receivingAmount({required double sendingAmount}) {
    double amount = 0;
    double charge = double.tryParse(_selectedSendingMethod?.amount ?? '0') ?? 0;
    if (_selectedSendingMethod?.type == '1') {
      amount = sendingAmount - (sendingAmount * (charge / 100));
    } else {
      amount = sendingAmount - charge;
    }

    return amount;
  }

  Future<http.Response?> createTransaction(
      {required PaymentRequest paymentRequest}) async {
    try {
      String token = _localStorage.token;
      http.Response response = await http.post(
        Uri.parse(baseUrl + paymentEp),
        body: paymentRequest.toJson(),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        _selectedSendingMethod = null;
        _selectedReceivingMethod = null;
        _transactionDate = null;
        _transactionTime = null;
      }
      notifyListeners();

      return response;
    } catch (e, s) {
      log("transaction create info error - $e, stack trace - $s");
      return null;
    }
  }

  void clearCreateTransactionData() {
    _selectedSendingMethod = null;
    _selectedReceivingMethod = null;
    _transactionDate = null;
    _transactionTime = null;

    notifyListeners();
  }
}
