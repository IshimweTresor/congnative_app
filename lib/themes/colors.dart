import 'package:flutter/material.dart';

class AppColors {
  // Light theme colors
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF2196F3),
    onPrimary: Colors.white,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    error: Color(0xFFB00020),
    onError: Colors.white,
    surface: Color(0xFFF5F5F5),
    onSurface: Colors.black,
  );

  // Dark theme colors
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF2196F3),
    onPrimary: Colors.white,
    secondary: Color(0xFF03DAC6),
    onSecondary: Colors.black,
    error: Color(0xFFCF6679),
    onError: Colors.black,
    surface: Color(0xFF121212),
    onSurface: Colors.white,
  );

  // Custom colors for cognitive disability app
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color calmBlue = Color(0xFF81D4FA);
  static const Color lightGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF757575);
}
