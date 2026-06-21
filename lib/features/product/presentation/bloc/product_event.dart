import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {}

class LoadMoreProductsEvent extends ProductEvent {}

class FilterProductsEvent extends ProductEvent {
  final String? query;
  final String? category;

  const FilterProductsEvent({this.query, this.category});

  @override
  List<Object?> get props => [query, category];
}
