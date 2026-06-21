import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/core/usecase/usecase.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';
import 'package:liveewire_products/features/product/domain/repositories/product_repository.dart';

class GetProductDetailsUseCase implements UseCase<ProductEntity, int> {
  final ProductRepository repository;

  GetProductDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, ProductEntity>> call(int id) async {
    return await repository.getProductDetails(id);
  }
}
