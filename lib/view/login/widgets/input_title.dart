import 'package:flutter/material.dart';

class InputTitle extends StatelessWidget {
  final String title;

  const InputTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
