
import 'package:caffeine/features/cart/data/cart_model.dart';
import 'package:equatable/equatable.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartError extends CartState{
  final String message;

  const CartError(this.message);
  @override
  List<Object> get props => [message];

}
final class CartLoaded extends CartState {
  final List<CartModel> cartItems;

  const CartLoaded(this.cartItems);
  @override
  List<Object> get props => [cartItems];

}
final class CartItemAdded extends CartState {
  final String message;

  const CartItemAdded(this.message);
  @override
  List<Object> get props => [message];

}
final class CartItemDeleted extends CartState {
  final String message;

  const CartItemDeleted(this.message);
  @override
  List<Object> get props => [message];

}
final class CartDeleted extends CartState {
  final String message;

  const CartDeleted(this.message);
  @override
  List<Object> get props => [message];

}

