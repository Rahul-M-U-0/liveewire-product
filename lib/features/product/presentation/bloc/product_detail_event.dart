import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductDetailsEvent extends ProductDetailEvent {
  final int id;

  const FetchProductDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
