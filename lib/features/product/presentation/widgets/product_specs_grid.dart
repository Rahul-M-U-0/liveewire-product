import 'package:flutter/material.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

class ProductSpecsGrid extends StatelessWidget {
  final ProductEntity product;

  const ProductSpecsGrid({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final specs = [
      {
        'icon': Icons.branding_watermark_outlined,
        'label': AppStrings.brand,
        'val': product.brand,
      },
      {
        'icon': Icons.category_outlined,
        'label': AppStrings.category,
        'val': product.category,
      },
      {
        'icon': Icons.inventory_2_outlined,
        'label': AppStrings.stockAvailable,
        'val': '${product.stock} ${AppStrings.units}',
      },
      {
        'icon': Icons.star_rate_outlined,
        'label': AppStrings.ratingLabel,
        'val': '${product.rating} / 5.0',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: specs.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final spec = specs[index];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.25,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                spec['icon'] as IconData,
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      spec['label'] as String,
                      style: TextStyle(
                        color: theme.colorScheme.outline,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      spec['val'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
