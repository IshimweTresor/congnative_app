import 'package:flutter/material.dart';
import 'colors.dart';
import 'text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.lightColorScheme,
    textTheme: AppTextStyles.lightTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightColorScheme.primary,
      foregroundColor: AppColors.lightColorScheme.onPrimary,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightColorScheme.primary,
        foregroundColor: AppColors.lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.lightColorScheme.surface,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.darkColorScheme,
    textTheme: AppTextStyles.darkTextTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColorScheme.primary,
      foregroundColor: AppColors.darkColorScheme.onPrimary,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkColorScheme.primary,
        foregroundColor: AppColors.darkColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.darkColorScheme.surface,
    ),
  );
}
