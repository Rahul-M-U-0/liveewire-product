import 'package:equatable/equatable.dart';
import 'package:liveewire_products/features/product/domain/entities/product_entity.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddProductEvent extends CartEvent {
  final ProductEntity product;
  const AddProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveProductEvent extends CartEvent {
  final ProductEntity product;
  const RemoveProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends CartEvent {
  final ProductEntity product;
  const DeleteProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class ClearCartEvent extends CartEvent {}
