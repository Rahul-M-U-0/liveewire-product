import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/di/di.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/core/widgets/shimmer_loading.dart';
import 'package:liveewire_products/features/cart/presentation/widgets/cart_badge.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_detail_bloc.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_detail_bottom_bar.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_image_slider.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_rating_stars.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_reviews_section.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_specs_grid.dart';
import 'package:liveewire_products/features/product/presentation/widgets/stock_indicator.dart';

class ProductDetailPage extends StatelessWidget {
  static const String routeName = 'product-detail';
  static const String routePath = '/product-detail/:id';

  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (_) =>
          sl<ProductDetailBloc>()..add(FetchProductDetailsEvent(productId)),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading || state is ProductDetailInitial) {
            return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.loading)),
              body: const ProductDetailShimmer(),
            );
          } else if (state is ProductDetailError) {
            return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.error)),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${AppStrings.errorPrefix} ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductDetailBloc>().add(
                          FetchProductDetailsEvent(productId),
                        );
                      },
                      child: const Text(AppStrings.retry),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductDetailLoaded) {
            final product = state.product;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: const [CartBadge()],
              ),
              body: _buildProductDetailBody(context, product),
              bottomNavigationBar: ProductDetailBottomBar(product: product),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProductDetailBody(BuildContext context, ProductEntity product) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        final bloc = context.read<ProductDetailBloc>();
        bloc.add(FetchProductDetailsEvent(product.id));
        await bloc.stream.firstWhere((s) => s is! ProductDetailLoading);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium Image Slider
            ProductImageSlider(images: product.images),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand & Category Headers
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.brand,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        product.category.toUpperCase(),
                        style: TextStyle(
                          color: theme.colorScheme.outline,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Product Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Rating Score & Stock status
                  Row(
                    children: [
                      ProductRatingStars(rating: product.rating, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      StockIndicator(product: product),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Key Specifications Grid
                  Text(
                    AppStrings.specifications,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ProductSpecsGrid(product: product),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    AppStrings.aboutThisItem,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  ProductReviewsSection(product: product),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
