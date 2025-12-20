import 'dart:developer';

import 'package:caffeine/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:caffeine/features/cart/data/cart_model.dart';
import 'package:caffeine/features/cart/data/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartRepo _cartRepo;
  CartCubit({required CartRepo cartRepo})
    : _cartRepo = cartRepo,
      super(CartState());
  void addToCart(int productId, double price) async {
    emit(CartState(isLoading: true));
    try {
      await _cartRepo.addToCart(productId, price);
      emit(CartState(successMessage: 'تم إضافة المنتج إلى السلة'));
      // Refresh cart items after adding
      getCartItems();
    } catch (e) {
      emit(CartState(errorMessage: e.toString()));
    }
  }

  void getCartItems() async {
    emit(CartState(isLoading: true));
    final result = await _cartRepo.getCartItems();
    log(result.toString());
    result.fold((l) => emit(CartState(errorMessage: l)), (r) => emit(CartState(cartItems: r)));
  }

  void delete(int cartId) async {
    emit(CartState(isLoading: true));
    try {
      await _cartRepo.delete(cartId);
      emit(CartState(successMessage: 'تم حذف المنتج من السلة'));
      getCartItems();
    } catch (e) {
      emit(CartState(errorMessage: e.toString()));
    }
  }
  void deleteall() async {
    emit(CartState(isLoading: true));
    try {
      await _cartRepo.deleteAll();
      emit(CartState(successMessage: 'تم حذف جميع المنتجات من السلة'));
      getCartItems();
    } catch (e) {
      emit(CartState(errorMessage: e.toString()));
    }
  }
  double calculateTotal(
  List<CartModel> cartItems,
  Map<int, int> productCounts,
) {
  return cartItems.fold<double>(
    0,
    (sum, item) =>
        sum + (item.realPrice * (productCounts[item.product.id] ?? 1)),
  );
}
}