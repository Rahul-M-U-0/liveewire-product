import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/widgets/shimmer_loading.dart';
import 'package:liveewire_products/features/product/presentation/bloc/category_bloc.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_bloc.dart';

class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.isLoading && state.categories.isEmpty) {
          return const CategoryShimmer();
        }
        final categories = state.categories;
        if (categories.isNotEmpty) {
          return Container(
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final categorySlug = isAll ? 'All' : categories[index - 1].slug;
                final categoryName = isAll ? 'All' : categories[index - 1].name;
                return BlocBuilder<ProductBloc, ProductState>(
                  buildWhen: (previous, current) =>
                      previous.selectedCategory != current.selectedCategory,
                  builder: (context, productState) {
                    final isSelected =
                        productState.selectedCategory.toLowerCase() ==
                            categorySlug.toLowerCase();
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        showCheckmark: false,
                        label: Text(
                          categoryName,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        onSelected: (_) {
                          context.read<ProductBloc>().add(
                                FilterProductsEvent(category: categorySlug),
                              );
                        },
                        selectedColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : Theme.of(context)
                                    .colorScheme
                                    .outlineVariant
                                    .withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
