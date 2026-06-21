import 'package:flutter/material.dart';
import 'package:liveewire_products/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool filled;
  final Color? fillColor;
  final BorderRadius? borderRadius;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.filled = true,
    this.fillColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRad = borderRadius ?? BorderRadius.circular(16);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
          fontSize: 15,
        ),
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.8,
                  ),
                ),
                child: prefixIcon!,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.8,
                  ),
                ),
                child: suffixIcon!,
              )
            : null,
        filled: filled,
        fillColor:
            fillColor ??
            (theme.brightness == Brightness.light
                ? Colors.white
                : theme.colorScheme.surfaceContainerHighest.withValues(
                    alpha: 0.5,
                  )),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRad,
          borderSide: BorderSide(
            color: theme.brightness == Brightness.light
                ? AppColors.lightBorder
                : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRad,
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRad,
          borderSide: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
    );
  }
}
