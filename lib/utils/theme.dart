import 'package:flutter/material.dart';
import 'package:transfer/utils/text_theme.dart';

import 'app_colors.dart';
import 'color_scheme.dart';

// --------------------------------------
// Light Theme Data
// --------------------------------------
final lightThemeData = ThemeData(
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
    ),
    colorScheme: lightColorScheme,
    textTheme: lightTextTheme,
    iconTheme: const IconThemeData(
      color: AppColors.darkTextColor,
    ),
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      centerTitle: false,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: lightTextTheme.titleLarge?.copyWith(fontSize: 18, color: Colors.white),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(1),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.primaryColor),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          textStyle: MaterialStateProperty.all<TextStyle>(
            lightTextTheme.titleMedium!.copyWith(color: Colors.white),
          )),
    ),
    snackBarTheme: SnackBarThemeData(
      contentTextStyle: lightTextTheme.titleSmall,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xffF5F5F5),
      isDense: true,
      filled: true,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.grey)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.grey)),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      labelStyle: lightTextTheme.bodyMedium,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
            side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(width: 1.5, color: AppColors.primaryColor)),
            textStyle: MaterialStateProperty.all<TextStyle>(
              lightTextTheme.titleMedium!
                  .copyWith(color: AppColors.primaryColor),
            )))
// checkboxTheme: CheckboxThemeData(
//     checkColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
//     fillColor: MaterialStateProperty.all<Color>(Colors.red),
//     shape: const RoundedRectangleBorder(
//       side: BorderSide(
//         color: AppColors.primaryColor,
//       )
//     ),
//
// )
    );

// --------------------------------------
// Dark Theme Data
// --------------------------------------
final darkThemeData = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: darkTextTheme,
  iconTheme: const IconThemeData(
    color: AppColors.primaryColor,
  ),
  scaffoldBackgroundColor: AppColors.darkBackgroundColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: lightTextTheme.titleSmall,
  ),
);
