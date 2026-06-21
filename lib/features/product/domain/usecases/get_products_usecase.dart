import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/core/usecase/usecase.dart';
import 'package:liveewire_products/features/product/domain/entities/paginated_products.dart';
import 'package:liveewire_products/features/product/domain/repositories/product_repository.dart';

class GetProductsParams extends Equatable {
  final int limit;
  final int skip;
  final String? category;
  final String? query;

  const GetProductsParams({
    this.limit = 10,
    this.skip = 0,
    this.category,
    this.query,
  });

  @override
  List<Object?> get props => [limit, skip, category, query];
}

class GetProductsUseCase
    implements UseCase<PaginatedProducts, GetProductsParams> {
  final ProductRepository repository;

  GetProductsUseCase({required this.repository});

  @override
  Future<Either<Failure, PaginatedProducts>> call(
    GetProductsParams params,
  ) async {
    return await repository.getProducts(
      limit: params.limit,
      skip: params.skip,
      category: params.category,
      query: params.query,
    );
  }
}
