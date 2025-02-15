import 'package:flutter/material.dart';

extension TransactionStatusExtension on String {
  String transactionStatus() {
    if(this == '1') {
      return "Pending";
    } else if(this == '2') {
      return "Success";
    } else if(this == '3') {
      return "Amount not get";
    } else if(this == '4') {
      return "Failed";
    } else if (this == '5') {
      return "Cancelled";
    } else if(this == '6'){
      return "Editable";
    } else {
      return "Failed";
    }
  }

  Color transactionStatusColor() {
    if(this == '1') {
      return Colors.deepOrange;
    } else if(this == '2') {
      return Colors.green;
    } else if(this == '3') {
      return Colors.red.shade800;
    } else if(this == '4') {
      return Colors.red.shade800;
    } else if (this == '5') {
      return Colors.red.shade800;
    } else if(this == '6'){
      return Colors.black;
    } else {
      return Colors.red.shade800;
    }
  }
}