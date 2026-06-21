import 'package:flutter/material.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_bloc.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  final ScrollController scrollController;
  final List<ProductEntity> products;
  final ProductLoaded state;
  final Future<void> Function() onRefresh;

  const ProductGrid({
    super.key,
    required this.scrollController,
    required this.products,
    required this.state,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return ProductCard(product: products[index]);
              }, childCount: products.length),
            ),
          ),
          if (state.isLoadingMore)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
