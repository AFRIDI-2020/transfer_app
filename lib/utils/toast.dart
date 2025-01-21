import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:transfer/utils/app_colors.dart';

void toast({required String message, bool? isError,}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: isError == true ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 15,
  );
}