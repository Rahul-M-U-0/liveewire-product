import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/usecase/usecase.dart';
import 'package:liveewire_products/features/product/domain/usecases/get_categories_usecase.dart';
import 'package:liveewire_products/features/product/presentation/bloc/category_event.dart';
import 'package:liveewire_products/features/product/presentation/bloc/category_state.dart';

export 'package:liveewire_products/features/product/presentation/bloc/category_event.dart';
export 'package:liveewire_products/features/product/presentation/bloc/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc({required this.getCategoriesUseCase})
    : super(const CategoryInitial()) {
    on<FetchCategoriesEvent>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(
    FetchCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading(categories: state.categories));
    final result = await getCategoriesUseCase(NoParams());
    result.fold(
      (failure) =>
          emit(CategoryError(failure.message, categories: state.categories)),
      (categories) => emit(CategoryLoaded(categories: categories)),
    );
  }
}
