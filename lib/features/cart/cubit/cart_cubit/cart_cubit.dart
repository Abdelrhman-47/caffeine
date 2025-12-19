import 'dart:developer';

import 'package:caffeine/features/cart/cubit/cart_cubit/cart_state.dart';
import 'package:caffeine/features/cart/data/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartRepo _cartRepo;
  CartCubit({required CartRepo cartRepo})
    : _cartRepo = cartRepo,
      super(CartInitial());
  void addToCart(int productId, double price) async {
    emit(CartLoading());
    try {
      await _cartRepo.addToCart(productId, price);
      emit(CartItemAdded('تم إضافة المنتج إلى السلة'));
      // Refresh cart items after adding
      getCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void getCartItems() async {
    emit(CartLoading());
    final result = await _cartRepo.getCartItems();
    log(result.toString());
    result.fold((l) => emit(CartError(l)), (r) => emit(CartLoaded(r)));
  }

  void delete(int cartId) async {
    emit(CartLoading());
    try {
      await _cartRepo.delete(cartId);
      emit(CartItemDeleted('تم حذف المنتج من السلة'));
      getCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
  void deleteall() async {
    emit(CartLoading());
    try {
      await _cartRepo.deleteAll();
      emit(CartDeleted('تم حذف جميع المنتجات من السلة'));
      getCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
