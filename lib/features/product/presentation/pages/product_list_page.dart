import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/constants/app_strings.dart';
import 'package:liveewire_products/core/widgets/shimmer_loading.dart';
import 'package:liveewire_products/features/cart/presentation/widgets/cart_badge.dart';
import 'package:liveewire_products/features/product/presentation/bloc/category_bloc.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_bloc.dart';
import 'package:liveewire_products/features/product/presentation/widgets/category_filter_chips.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_empty_state.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_grid.dart';
import 'package:liveewire_products/features/product/presentation/widgets/product_search_bar.dart';

class ProductListPage extends StatefulWidget {
  static const String routeName = 'products';
  static const String routePath = '/products';

  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchCategoriesEvent());
    context.read<ProductBloc>().add(FetchProductsEvent());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductBloc>().add(LoadMoreProductsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        actions: const [CartBadge()],
      ),
      body: Column(
        children: [
          // Search Bar Widget
          ProductSearchBar(controller: _searchController),

          // Categories chips selector Widget
          const CategoryFilterChips(),

          // Product List/Grid View Section
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const ProductGridShimmer();
                } else if (state is ProductError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${AppStrings.errorPrefix} ${state.message}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<ProductBloc>().add(
                                FilterProductsEvent(
                                  query: state.searchQuery,
                                  category: state.selectedCategory,
                                ),
                              ),
                          child: const Text(AppStrings.retry),
                        ),
                      ],
                    ),
                  );
                } else if (state is ProductLoaded) {
                  final products = state.products;
                  if (products.isEmpty) {
                    return ProductEmptyState(state: state);
                  }

                  return ProductGrid(
                    scrollController: _scrollController,
                    products: products,
                    state: state,
                    onRefresh: () async {
                      final bloc = context.read<ProductBloc>();
                      bloc.add(
                        FilterProductsEvent(
                          query: state.searchQuery,
                          category: state.selectedCategory,
                        ),
                      );
                      await bloc.stream.firstWhere((s) => s is! ProductLoading);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
