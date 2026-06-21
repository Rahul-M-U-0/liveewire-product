import 'package:liveewire_products/features/product/domain/entities/paginated_products.dart';
import 'package:liveewire_products/features/product/data/models/product_model.dart';

class PaginatedProductsModel extends PaginatedProducts {
  const PaginatedProductsModel({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory PaginatedProductsModel.fromJson(Map<String, dynamic> json) {
    final productsList =
        (json['products'] as List<dynamic>?)
            ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return PaginatedProductsModel(
      products: productsList,
      total: json['total'] as int? ?? 0,
      skip: json['skip'] as int? ?? 0,
      limit: json['limit'] as int? ?? 0,
    );
  }
}
