import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData nostalgic = ThemeData(
    primaryColor: const Color(0xFF3A5A40), // deep postal green
    scaffoldBackgroundColor: const Color(0xFFF8F3E7), // vintage paper
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF3A5A40),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFFFFBF2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFB8A27A)),
      ),
    ),
  );
}
