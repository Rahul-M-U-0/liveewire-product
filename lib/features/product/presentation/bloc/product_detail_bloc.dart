import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/features/product/domain/usecases/get_product_details_usecase.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_detail_event.dart';
import 'package:liveewire_products/features/product/presentation/bloc/product_detail_state.dart';

export 'package:liveewire_products/features/product/presentation/bloc/product_detail_event.dart';
export 'package:liveewire_products/features/product/presentation/bloc/product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailBloc({required this.getProductDetailsUseCase})
    : super(ProductDetailInitial()) {
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
  }

  Future<void> _onFetchProductDetails(
    FetchProductDetailsEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    final result = await getProductDetailsUseCase(event.id);
    result.fold(
      (failure) => emit(ProductDetailError(failure.message)),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }
}
