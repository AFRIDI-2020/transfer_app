import 'package:flutter/material.dart';

class AddHorizontalSpace extends StatelessWidget {
  final double value;

  const AddHorizontalSpace({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value,
    );
  }
}
