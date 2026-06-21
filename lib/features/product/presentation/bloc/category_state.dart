import 'package:equatable/equatable.dart';
import 'package:liveewire_products/features/product/domain/entities/category_entity.dart';

abstract class CategoryState extends Equatable {
  final List<CategoryEntity> categories;
  final bool isLoading;
  final String? errorMessage;

  const CategoryState({
    required this.categories,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [categories, isLoading, errorMessage];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial() : super(categories: const [], isLoading: false);
}

class CategoryLoading extends CategoryState {
  const CategoryLoading({required super.categories}) : super(isLoading: true);
}

class CategoryLoaded extends CategoryState {
  const CategoryLoaded({required super.categories}) : super(isLoading: false);
}

class CategoryError extends CategoryState {
  const CategoryError(String message, {required super.categories})
    : super(isLoading: false, errorMessage: message);

  @override
  List<Object?> get props => [categories, isLoading, errorMessage];
}
