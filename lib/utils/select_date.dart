import 'package:flutter/material.dart';

Future<DateTime?> selectDate(BuildContext context,
    {DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(DateTime.now().year - 10, DateTime.now().month, DateTime.now().day),
    lastDate: lastDate ?? DateTime(DateTime.now().year + 10, DateTime.now().month, DateTime.now().day),
    builder: (context, child) {
      return child!;
    },
  );
  return picked;
}