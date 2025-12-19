import 'dart:developer';

import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/features/order/data/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class OrderRepo {
  Future<void> placeOrder({
    required int count,
    required double itemPrice,
    required int productId,
    required double totalPrice,
  });
  Future<List<OrderModel>> getUserOrders();
  Future<void>deleteall();
}

class OrderRepoImpl implements OrderRepo {
  final ApiServices _apiServices;
  final supabase = Supabase.instance.client;

  OrderRepoImpl({required ApiServices apiServices})
    : _apiServices = apiServices;

  @override
  Future<void> placeOrder({
    required int count,
    required double itemPrice,
    required int productId,
    required double totalPrice,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'count': count,
        'item_price': itemPrice,
        'product_id': productId,
        'user_id': supabase.auth.currentUser!.id,
        'total_price': totalPrice,
      };
      await _apiServices.post('user_order', body);
    } catch (e) {
      log('error in placeOrder $e');
      rethrow;
    }
  }

  @override
  Future<List<OrderModel>> getUserOrders() async {
    try {
      final response = await _apiServices.get(
        'user_order?select=*,products(*)&user_id=eq.${supabase.auth.currentUser!.id}',
      );
      final List<dynamic> data = response;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      log('error in getUserOrders $e');
      rethrow;
    }
  }
  
  @override
  Future<void> deleteall() {
    try {
      return _apiServices.delete(
        'user_order?user_id=eq.${supabase.auth.currentUser!.id}',
      );
    } catch (e) {
      log('error in deleteall $e');
      rethrow;
    }    
  }
}
