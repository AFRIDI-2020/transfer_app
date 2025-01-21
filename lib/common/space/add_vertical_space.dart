import 'package:flutter/material.dart';

class AddVerticalSpace extends StatelessWidget {
  final double value;

  const AddVerticalSpace({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}
