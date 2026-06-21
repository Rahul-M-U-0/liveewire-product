import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/core/utils/snackbar_utils.dart';
import 'package:liveewire_products/features/cart/domain/entities/cart_item_entity.dart';
import 'package:liveewire_products/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

class ProductDetailBottomBar extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailBottomBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppStrings.price,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '₹${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      int quantity = 0;
                      if (state is CartLoaded) {
                        final cartItem = state.items
                            .cast<CartItemEntity>()
                            .firstWhere(
                              (item) => item.product.id == product.id,
                              orElse: () =>
                                  CartItemEntity(product: product, quantity: 0),
                            );
                        quantity = cartItem.quantity;
                      }

                      if (quantity > 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildQuantityButton(
                              context,
                              icon: Icons.remove,
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  RemoveProductEvent(product),
                                );
                              },
                            ),
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            _buildQuantityButton(
                              context,
                              icon: Icons.add,
                              onPressed: () {
                                context.read<CartBloc>().add(
                                  AddProductEvent(product),
                                );
                              },
                            ),
                          ],
                        );
                      }

                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          context.read<CartBloc>().add(
                            AddProductEvent(product),
                          );
                          showSnackBar(
                            context,
                            '${product.title} ${AppStrings.addedToCartSuffix}',
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_checkout, size: 20),
                            SizedBox(width: 8),
                            Text(
                              AppStrings.addToCart,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
