import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liveewire_products/core/usecase/usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/get_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/delete_from_cart_usecase.dart';
import 'package:liveewire_products/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:liveewire_products/features/cart/presentation/bloc/cart_event.dart';
import 'package:liveewire_products/features/cart/presentation/bloc/cart_state.dart';

export 'package:liveewire_products/features/cart/presentation/bloc/cart_event.dart';
export 'package:liveewire_products/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final DeleteFromCartUseCase deleteFromCartUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.deleteFromCartUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddProductEvent>(_onAddProduct);
    on<RemoveProductEvent>(_onRemoveProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    final result = await getCartUseCase(NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(items)),
    );
  }

  Future<void> _onAddProduct(
    AddProductEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await addToCartUseCase(event.product);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(items)),
    );
  }

  Future<void> _onRemoveProduct(
    RemoveProductEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await removeFromCartUseCase(event.product);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(items)),
    );
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await deleteFromCartUseCase(event.product);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(items)),
    );
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    final result = await clearCartUseCase(NoParams());
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (items) => emit(CartLoaded(items)),
    );
  }
}
