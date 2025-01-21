import 'package:flutter/material.dart';
import 'package:transfer/utils/app_colors.dart';

class ButtonChild extends StatelessWidget {
  final String text;
  final bool? loading;
  final Color? textColor;

  const ButtonChild({Key? key, required this.text, this.loading, this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          )
        : Text(
            text,
            style:  TextStyle(color: textColor),
          );
  }
}
