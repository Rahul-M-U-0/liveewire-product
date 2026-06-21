import 'package:liveewire_products/features/cart/domain/entities/cart_item_entity.dart';
import 'package:liveewire_products/features/product/data/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({required super.product, required super.quantity});

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    final productModel = ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      category: product.category,
      price: product.price,
      rating: product.rating,
      stock: product.stock,
      brand: product.brand,
      thumbnail: product.thumbnail,
      images: product.images,
      reviews: product.reviews,
    );
    return {'product': productModel.toJson(), 'quantity': quantity};
  }
}
