import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  Duration duration = const Duration(seconds: 2),
  bool isError = false,
}) {
  final theme = Theme.of(context);

  final backgroundColor = isError
      ? theme.colorScheme.errorContainer
      : theme.colorScheme.inverseSurface;

  final textColor = isError
      ? theme.colorScheme.onErrorContainer
      : theme.colorScheme.onInverseSurface;

  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      duration: duration,
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'Lato',
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
