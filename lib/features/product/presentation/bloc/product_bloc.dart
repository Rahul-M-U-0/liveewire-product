import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/features/product/domain/usecases/get_products_usecase.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_event.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_state.dart';

export 'package:liveewire_products/features/product/presentation/bloc/product_event.dart';
export 'package:liveewire_products/features/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc({required this.getProductsUseCase})
    : super(const ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
    on<FilterProductsEvent>(_onFilterProducts);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());

    final result = await getProductsUseCase(
      const GetProductsParams(limit: 10, skip: 0),
    );
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (paginated) => emit(
        ProductLoaded(
          products: paginated.products,
          skip: paginated.skip,
          total: paginated.total,
          hasReachedMax: paginated.products.length >= paginated.total,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! ProductLoaded) return;
    final currentState = state as ProductLoaded;
    if (currentState.hasReachedMax || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final result = await getProductsUseCase(
      GetProductsParams(
        limit: 10,
        skip: currentState.products.length,
        category: currentState.selectedCategory,
        query: currentState.searchQuery,
      ),
    );

    result.fold(
      (failure) => emit(currentState.copyWith(isLoadingMore: false)),
      (paginated) {
        final updatedProducts = List<ProductEntity>.from(currentState.products)
          ..addAll(paginated.products);
        emit(
          currentState.copyWith(
            products: updatedProducts,
            skip: paginated.skip,
            total: paginated.total,
            hasReachedMax: updatedProducts.length >= paginated.total,
            isLoadingMore: false,
          ),
        );
      },
    );
  }

  Future<void> _onFilterProducts(
    FilterProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (state is! ProductLoaded &&
        state is! ProductInitial &&
        state is! ProductError)
      return;

    final currentQuery = state.searchQuery;
    final currentCategory = state.selectedCategory;

    final newQuery = event.query ?? currentQuery;
    final newCategory = event.category ?? currentCategory;

    emit(ProductLoading(searchQuery: newQuery, selectedCategory: newCategory));

    final result = await getProductsUseCase(
      GetProductsParams(
        limit: 10,
        skip: 0,
        category: newCategory,
        query: newQuery,
      ),
    );

    result.fold(
      (failure) => emit(
        ProductError(
          failure.message,
          searchQuery: newQuery,
          selectedCategory: newCategory,
        ),
      ),
      (paginated) {
        emit(
          ProductLoaded(
            products: paginated.products,
            searchQuery: newQuery,
            selectedCategory: newCategory,
            skip: paginated.skip,
            total: paginated.total,
            hasReachedMax: paginated.products.length >= paginated.total,
          ),
        );
      },
    );
  }
}
