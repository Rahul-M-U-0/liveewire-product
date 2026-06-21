import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:liveewire_products/features/cart/domain/entities/cart_item_entity.dart';
import 'package:liveewire_products/features/cart/domain/repositories/cart_repository.dart';

import 'package:liveewire_products/features/cart/data/models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCart() async {
    try {
      final cachedCart = await localDataSource.getCartItems();
      return Right(cachedCart);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCart(List<CartItemEntity> items) async {
    try {
      final models = items
          .map(
            (item) =>
                CartItemModel(product: item.product, quantity: item.quantity),
          )
          .toList();
      await localDataSource.saveCartItems(models);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
