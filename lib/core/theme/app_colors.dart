import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // --- Light Theme Colors ---
  static const Color lightPrimary = Color(0xFF3E60F6);
  static const Color lightSecondary = Color(0xFF262626);
  static const Color lightTertiary = Color(0xFFFFB000);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceContainer = Color(0xFFF2F2F2);
  static const Color lightScaffoldBackground = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFDBDBDB);
  static const Color lightError = Color(0xFFED4956);
  static const Color lightAppBarTitle = Color(0xFF000000);

  // Shimmer colors (Light)
  static const Color lightShimmerBase = Color(0xFFEFEFEF);
  static const Color lightShimmerHighlight = Color(0xFFFAFAFA);

  // --- Dark Theme Colors ---
  static const Color darkPrimary = Color(0xFF3E60F6);
  static const Color darkSecondary = Color(0xFFF5F5F5);
  static const Color darkTertiary = Color(0xFFFFB000);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkSurfaceContainer = Color(0xFF262626);
  static const Color darkScaffoldBackground = Color(0xFF000000);
  static const Color darkBorder = Color(0xFF262626);
  static const Color darkError = Color(0xFFED4956);
  static const Color darkAppBarTitle = Colors.white;

  // Shimmer colors (Dark)
  static const Color darkShimmerBase = Color(0xFF1C1C1E);
  static const Color darkShimmerHighlight = Color(0xFF2C2C2E);

  // --- Theme helper methods to easily get colors based on brightness/context ---
  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;
  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;
  static Color tertiary(BuildContext context) =>
      Theme.of(context).colorScheme.tertiary;
  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;
  static Color error(BuildContext context) =>
      Theme.of(context).colorScheme.error;
  static Color scaffoldBackground(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color border(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : lightBorder;
  }

  static Color shimmerBase(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkShimmerBase
        : lightShimmerBase;
  }

  static Color shimmerHighlight(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkShimmerHighlight
        : lightShimmerHighlight;
  }
}
