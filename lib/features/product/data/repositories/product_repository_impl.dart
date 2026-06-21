import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:liveewire_products/core/error/failures.dart';
import 'package:liveewire_products/features/product/data/datasources/product_remote_datasource.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';
import 'package:liveewire_products/features/product/domain/entities/category_entity.dart';
import 'package:liveewire_products/features/product/domain/entities/paginated_products.dart';
import 'package:liveewire_products/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedProducts>> getProducts({
    required int limit,
    required int skip,
    String? category,
    String? query,
  }) async {
    try {
      final remoteProducts = await remoteDataSource.getProducts(
        limit: limit,
        skip: skip,
        category: category,
        query: query,
      );
      return Right(remoteProducts);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetails(int id) async {
    try {
      final remoteProduct = await remoteDataSource.getProductDetails(id);
      return Right(remoteProduct);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final remoteCategories = await remoteDataSource.getCategories();
      return Right(remoteCategories);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _getErrorMessage(DioException e) {
    if (e.response != null && e.response!.data != null) {
      final data = e.response!.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'] as String;
      }
    }
    return e.message ?? 'Network error connecting to catalog server.';
  }
}
