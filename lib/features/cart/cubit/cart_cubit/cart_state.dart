// cart_state.dart
import 'package:caffeine/features/cart/data/cart_model.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartModel> cartItems;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const CartState({
    this.cartItems = const [],
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  CartState copyWith({
    List<CartModel>? cartItems,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [cartItems, isLoading, errorMessage, successMessage];
}