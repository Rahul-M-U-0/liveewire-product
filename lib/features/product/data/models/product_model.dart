import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String? ?? '',
      date: json['date'] as String? ?? '',
      reviewerName: json['reviewerName'] as String? ?? 'Anonymous',
      reviewerEmail: json['reviewerEmail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.rating,
    required super.stock,
    required super.brand,
    required super.thumbnail,
    required super.images,
    required super.reviews,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      brand: json['brand'] as String? ?? 'Generic',
      thumbnail: json['thumbnail'] as String? ?? '',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'thumbnail': thumbnail,
      'images': images,
      'reviews': reviews.map((e) {
        if (e is ReviewModel) {
          return e.toJson();
        }
        return {
          'rating': e.rating,
          'comment': e.comment,
          'date': e.date,
          'reviewerName': e.reviewerName,
          'reviewerEmail': e.reviewerEmail,
        };
      }).toList(),
    };
  }
}
