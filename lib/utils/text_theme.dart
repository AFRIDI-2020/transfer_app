import 'package:flutter/material.dart';

import 'app_colors.dart';

// --------------------------------------
// Light Text Theme
// --------------------------------------
TextTheme lightTextTheme = const TextTheme(
  headlineLarge:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 52),
  displayLarge:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 38),
  displayMedium: TextStyle(
      color: Colors.black, fontWeight: FontWeight.normal, fontSize: 25),
  displaySmall:
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
  headlineMedium:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
  headlineSmall:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
  titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold),
  titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold),
  titleSmall:
      TextStyle(color: Colors.black,  fontWeight: FontWeight.bold, fontSize: 12),
  bodyLarge:
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
  bodyMedium: TextStyle(
    color: AppColors.darkTextColor,
    fontSize: 14,
  ),
  bodySmall: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 12), // caption
);

// --------------------------------------
// Dark Text Theme
// --------------------------------------
const TextTheme darkTextTheme = TextTheme(
  headlineLarge:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 52),
  displayLarge:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 38),
  displayMedium:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
  displaySmall:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
  headlineMedium:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
  headlineSmall:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
  titleLarge:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
  titleMedium:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
  titleSmall:
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
  bodyLarge:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
  bodyMedium:
      TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
  bodySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 12), // caption
);
