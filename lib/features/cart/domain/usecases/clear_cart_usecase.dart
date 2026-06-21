import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/core/usecase/usecase.dart';
import 'package:liveewire_products/features/cart/domain/entities/cart_item_entity.dart';
import 'package:liveewire_products/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUseCase implements UseCase<List<CartItemEntity>, NoParams> {
  final CartRepository repository;

  ClearCartUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CartItemEntity>>> call(NoParams params) async {
    final saveResult = await repository.saveCart(const []);
    return saveResult.fold((failure) => Left(failure), (_) => const Right([]));
  }
}
