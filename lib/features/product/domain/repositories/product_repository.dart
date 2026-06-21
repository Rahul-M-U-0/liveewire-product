import 'package:dartz/dartz.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';
import 'package:liveewire_products/features/product/domain/entities/category_entity.dart';
import 'package:liveewire_products/features/product/domain/entities/paginated_products.dart';

abstract class ProductRepository {
  Future<Either<Failure, PaginatedProducts>> getProducts({
    required int limit,
    required int skip,
    String? category,
    String? query,
  });
  Future<Either<Failure, ProductEntity>> getProductDetails(int id);
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
