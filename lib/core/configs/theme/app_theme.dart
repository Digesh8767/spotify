import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primary,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    ),
  );
}
