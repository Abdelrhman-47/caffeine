import 'dart:developer';

import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/features/cart/data/cart_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CartRepo {
  Future<void> addToCart(int productId, double price);
  Future<Either<String, List<CartModel>>> getCartItems();
  Future<void> delete(int cartId);
  Future<void> deleteAll();
}

class CartRepoImpl implements CartRepo {
  final ApiServices _apiServices;
  final supabase = Supabase.instance.client;

  CartRepoImpl({required ApiServices apiServices}) : _apiServices = apiServices;

  @override
  Future<void> addToCart(int productId, double price) async {
    try {
      final Map<String, dynamic> body = {
        'product_id': productId,
        'real_price': price,
        "user_id": supabase.auth.currentUser!.id,
      };
      await _apiServices.post('cart', body);
    } catch (e) {
      log('error in add to cart$e');
    }
  }

  @override
  Future<Either<String, List<CartModel>>> getCartItems() async {
    try {
      final response = await _apiServices.get(
        'cart?user_id=eq.${supabase.auth.currentUser!.id}&select=*,products(*)',
      );
      final List<CartModel> res = (response as List)
          .map((e) => CartModel.fromJson(e))
          .toList();
      log(res.toString());
      return right(res);
    } catch (e) {
      log('Error fetching cart items: $e');
      return left(e.toString());
    }
  }

  @override
  Future<void> delete(int cartId) async {
    try {
      await _apiServices.delete(
        'cart?id=eq.$cartId&user_id=eq.${supabase.auth.currentUser!.id}',
      );
    } catch (e) {
      log('error in delete$e');
    }
  }
  
  @override
  Future<void> deleteAll() async {
    try {
      await _apiServices.delete(
        'cart?user_id=eq.${supabase.auth.currentUser!.id}',
      );
    } catch (e) {
      log('error in delete all$e');
    }
  }
}
