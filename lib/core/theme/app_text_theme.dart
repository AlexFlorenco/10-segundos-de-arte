import 'package:artes/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appTextTheme = ThemeData(
  fontFamily: 'ShantellSans',
  textSelectionTheme: const TextSelectionThemeData(
    selectionColor: AppColors.black,
  ),
  textTheme: const TextTheme(
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w900,
      height: 53 / 45,
    ),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.white),
    bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.black),
  ),
);
