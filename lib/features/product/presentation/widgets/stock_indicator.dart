import 'package:flutter/material.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

class StockIndicator extends StatelessWidget {
  final ProductEntity product;

  const StockIndicator({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;
    String status = AppStrings.inStock;
    if (product.stock == 0) {
      color = Colors.red;
      status = AppStrings.outOfStock;
    } else if (product.stock < 15) {
      color = Colors.orange;
      status = '${AppStrings.only} ${product.stock} ${AppStrings.left}';
    } else {
      status = '${AppStrings.inStock} (${product.stock})';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
