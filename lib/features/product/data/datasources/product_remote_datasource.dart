import 'package:liveewire_products/core/network/dio_client.dart';
import 'package:liveewire_products/features/product/data/models/product_model.dart';
import 'package:liveewire_products/features/product/data/models/category_model.dart';
import 'package:liveewire_products/features/product/data/models/paginated_products_model.dart';

abstract class ProductRemoteDataSource {
  Future<PaginatedProductsModel> getProducts({
    required int limit,
    required int skip,
    String? category,
    String? query,
  });
  Future<ProductModel> getProductDetails(int id);
  Future<List<CategoryModel>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<PaginatedProductsModel> getProducts({
    required int limit,
    required int skip,
    String? category,
    String? query,
  }) async {
    String path = 'products';
    final Map<String, dynamic> queryParams = {
      'limit': limit,
      'skip': skip,
      'select': 'id,title,price,brand,rating,thumbnail,category',
    };

    if (query != null && query.isNotEmpty) {
      path = 'products/search';
      queryParams['q'] = query;
    } else if (category != null &&
        category.isNotEmpty &&
        category.toLowerCase() != 'all') {
      path = 'products/category/$category';
    }

    final response = await dioClient.dio.get(
      path,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      return PaginatedProductsModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    final response = await dioClient.dio.get('products/$id');
    if (response.statusCode == 200) {
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dioClient.dio.get('products/categories');
    if (response.statusCode == 200) {
      final List<dynamic> categoriesJson = response.data as List<dynamic>;
      return categoriesJson
          .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
