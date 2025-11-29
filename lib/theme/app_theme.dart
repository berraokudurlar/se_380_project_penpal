import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFFDF6E4);     // paper cream
  static const accentLight = Color(0xFFF8E8C8);    // soft beige
  static const accent = Color(0xFFF4C98E);         // warm postal yellow
  static const textDark = Color(0xFF6B4423);       // deep brown
  static const textMedium = Color(0xFF8B5E3C);     // lighter brown
  static const border = Color(0xFF8B5E3C);         // border color
}

class AppTheme {
  static ThemeData penpal = ThemeData(
    brightness: Brightness.light,

    // Background
    scaffoldBackgroundColor: AppColors.background,

    // Primary color (buttons, active elements)
    primaryColor: AppColors.accent,

    // AppBar styling
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.textDark,
      elevation: 0,
    ),

    // Default font family for the app
    fontFamily: 'Georgia',

    // Text styles
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 70,
        fontFamily: 'DancingScript',
        color: AppColors.textDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: AppColors.textMedium,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.textDark,
      ),
    ),

    // TextField styling
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.textMedium),
      filled: true,
      fillColor: AppColors.accentLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.textDark, width: 2),
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textDark,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Georgia',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    // TextButtons (Sign Up)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textMedium,
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
