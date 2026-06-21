import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  const ReviewEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  @override
  List<Object?> get props => [
        rating,
        comment,
        date,
        reviewerName,
        reviewerEmail,
      ];
}

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final List<String> images;
  final List<ReviewEntity> reviews;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.reviews,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        rating,
        stock,
        brand,
        thumbnail,
        images,
        reviews,
      ];
}
