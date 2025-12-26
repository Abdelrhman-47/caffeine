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
  Future<void> ordered({required double totalPrice,String orderIs, String countIs});
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
  
  @override
  Future<void> ordered({required double totalPrice, String? orderIs, String? countIs}) async{
    final Map<String, dynamic> body = {
      "user_id": supabase.auth.currentUser!.id,
      "total_price": totalPrice,
      "order_is": orderIs,
      "count_is":countIs
    };
    try {
      return await _apiServices.post(
        'https://gaogtmhoavbrmblbbfwi.supabase.co/rest/v1/order_confirmed',
        body,
      );
    } catch (e) {
      log('error in ordered $e');
      rethrow;
    }
    
  }
}
