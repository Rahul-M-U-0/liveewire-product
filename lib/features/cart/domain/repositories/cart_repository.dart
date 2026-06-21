import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemEntity>>> getCart();
  Future<Either<Failure, void>> saveCart(List<CartItemEntity> items);
}
