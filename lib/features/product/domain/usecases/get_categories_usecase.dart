import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/core/usecase/usecase.dart';
import 'package:liveewire_products/features/product/domain/entities/category_entity.dart';
import 'package:liveewire_products/features/product/domain/repositories/product_repository.dart';

class GetCategoriesUseCase implements UseCase<List<CategoryEntity>, NoParams> {
  final ProductRepository repository;

  GetCategoriesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
