import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/core/usecase/usecase.dart';
import 'package:liveewire_products/features/cart/domain/entities/cart_item_entity.dart';
import 'package:liveewire_products/features/cart/domain/repositories/cart_repository.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

class AddToCartUseCase implements UseCase<List<CartItemEntity>, ProductEntity> {
  final CartRepository repository;

  AddToCartUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CartItemEntity>>> call(
    ProductEntity product,
  ) async {
    final getResult = await repository.getCart();
    return getResult.fold((failure) => Left(failure), (items) async {
      final currentItems = List<CartItemEntity>.from(items);
      final index = currentItems.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (index >= 0) {
        final existingItem = currentItems[index];
        currentItems[index] = existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        );
      } else {
        currentItems.add(CartItemEntity(product: product, quantity: 1));
      }

      final saveResult = await repository.saveCart(currentItems);
      return saveResult.fold(
        (failure) => Left(failure),
        (_) => Right(currentItems),
      );
    });
  }
}
