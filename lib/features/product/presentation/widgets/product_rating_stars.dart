import 'package:flutter/material.dart';

class ProductRatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const ProductRatingStars({
    super.key,
    required this.rating,
    this.size = 14,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Resolve colors from the theme color scheme
    final effectiveActiveColor = activeColor ?? theme.colorScheme.tertiary;
    final effectiveInactiveColor = inactiveColor ?? theme.colorScheme.outlineVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        double fillPercent = 0.0;
        if (rating >= index + 1) {
          fillPercent = 1.0;
        } else if (rating > index) {
          fillPercent = rating - index;
        }

        return Stack(
          children: [
            Icon(
              Icons.star,
              color: effectiveInactiveColor,
              size: size,
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: fillPercent,
                child: Icon(
                  Icons.star,
                  color: effectiveActiveColor,
                  size: size,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
