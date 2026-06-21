import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Lato',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.lightPrimary,
        brightness: Brightness.light,
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightSecondary,
        tertiary: AppColors.lightTertiary,
        surface: AppColors.lightSurface,
        surfaceContainerHighest: AppColors.lightSurfaceContainer,
        error: AppColors.lightError,
        primaryContainer: const Color(0xFFE0F1FF),
        onPrimaryContainer: AppColors.lightPrimary,
      ),
      scaffoldBackgroundColor: AppColors.lightScaffoldBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.lightAppBarTitle,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: AppColors.lightAppBarTitle),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
        color: Colors.white,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide.none,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Lato',
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.lightPrimary,
        brightness: Brightness.dark,
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkSecondary,
        tertiary: AppColors.darkTertiary,
        surface: AppColors.darkSurface,
        surfaceContainerHighest: AppColors.darkSurfaceContainer,
        error: AppColors.darkError,
        primaryContainer: const Color(0xFF1E2B5C),
        onPrimaryContainer: AppColors.darkPrimary,
      ),
      scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkScaffoldBackground,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.darkAppBarTitle,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: IconThemeData(color: AppColors.darkAppBarTitle),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        color: AppColors.darkSurface,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide.none,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
