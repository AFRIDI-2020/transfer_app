import 'package:flutter/material.dart';

import 'app_colors.dart';

// --------------------------------------
// Light Color scheme
// --------------------------------------
ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primaryColor,
  onPrimary: Colors.white,
  secondary: AppColors.secondaryColor,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  background: AppColors.lightBackgroundColor,
  onBackground: Colors.black,
  surface: Colors.white,
  onSurface: Colors.black,
  shadow: AppColors.hint,
  outline: AppColors.divider,
);

// --------------------------------------
// Dark Color scheme
// --------------------------------------
ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryColor,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryColor,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: AppColors.darkBackgroundColor,
    onBackground: Colors.white,
    surface: AppColors.darkBackgroundColor,
    onSurface: Colors.white,
    shadow: AppColors.hint,
    outline: AppColors.border);
