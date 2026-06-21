import 'package:equatable/equatable.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  final String searchQuery;
  final String selectedCategory;

  const ProductState({this.searchQuery = '', this.selectedCategory = 'All'});

  @override
  List<Object?> get props => [searchQuery, selectedCategory];
}

class ProductInitial extends ProductState {
  const ProductInitial({super.searchQuery, super.selectedCategory});
}

class ProductLoading extends ProductState {
  const ProductLoading({super.searchQuery, super.selectedCategory});
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final int skip;
  final int total;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const ProductLoaded({
    required this.products,
    super.searchQuery = '',
    super.selectedCategory = 'All',
    required this.skip,
    required this.total,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  ProductLoaded copyWith({
    List<ProductEntity>? products,
    String? searchQuery,
    String? selectedCategory,
    int? skip,
    int? total,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      skip: skip ?? this.skip,
      total: total ?? this.total,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    products,
    searchQuery,
    selectedCategory,
    skip,
    total,
    hasReachedMax,
    isLoadingMore,
  ];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message, {super.searchQuery, super.selectedCategory});

  @override
  List<Object?> get props => [message, searchQuery, selectedCategory];
}
