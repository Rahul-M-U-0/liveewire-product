import 'package:equatable/equatable.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

class PaginatedProducts extends Equatable {
  final List<ProductEntity> products;
  final int total;
  final int skip;
  final int limit;

  const PaginatedProducts({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  @override
  List<Object?> get props => [products, total, skip, limit];
}
