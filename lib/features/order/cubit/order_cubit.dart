import 'package:caffeine/features/cart/data/cart_model.dart';
import 'package:caffeine/features/order/cubit/order_state.dart';
import 'package:caffeine/features/order/data/order_model.dart';
import 'package:caffeine/features/order/data/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;

  OrderCubit({required OrderRepo orderRepo})
    : _orderRepo = orderRepo,
      super(OrderState.initial());

  Future<void> _placeOrderInternal({
    required int count,
    required double itemPrice,
    required int productId,
    required double totalPrice,
  }) async {
    await _orderRepo.placeOrder(
      count: count,
      itemPrice: itemPrice,
      productId: productId,
      totalPrice: totalPrice,
    );
  }

  Future<void> placeOrder({
    required int count,
    required double itemPrice,
    required int productId,
    required double totalPrice,
  }) async {
    emit(OrderState.loading());
    try {
      await _placeOrderInternal(
        count: count,
        itemPrice: itemPrice,
        productId: productId,
        totalPrice: totalPrice,
      );

      emit(OrderState.success());
    } catch (e) {
      emit(OrderState.error(e.toString()));
    }
  }

  Future<void> getUserOrders() async {
    emit(OrderState.loading());
    try {
      final orders = await _orderRepo.getUserOrders();
      emit(OrderState.loaded(orders: orders));
    } catch (e) {
      emit(OrderState.error(e.toString()));
    }
  }

  Future<void> deleteall() async {
    emit(OrderState.loading());
    try {
      await _orderRepo.deleteall();
      emit(OrderState.success());
    } catch (e) {
      emit(OrderState.error(e.toString()));
    }
  }
  Future<void> ordered({required double totalPrice, required String orderIs, required String countIs}) async {
    emit(OrderState.loading());
    try {
      await _orderRepo.ordered(totalPrice: totalPrice, orderIs: orderIs, countIs: countIs);
      emit(OrderState.success());
    } catch (e) {
      emit(OrderState.error(e.toString()));
    }
  }
  

  double calculateTotalPrice(List<dynamic> orders) {
    return orders.fold<double>(0, (sum, order) => sum + order.totalPrice);
  }

  Future<void> confirmCartOrders({
    required List<CartModel> cartItems,
    required Map<int, int> productCounts,
  }) async {
    emit(OrderState.loading());

    try {
      for (var item in cartItems) {
        final count = productCounts[item.product.id] ?? 1;
        if (count > 0) {
          await _placeOrderInternal(
            count: count,
            itemPrice: item.realPrice,
            productId: item.product.id,
            totalPrice: item.realPrice * count,
          );
        }
      }

      emit(OrderState.success());
    } catch (e) {
      emit(OrderState.error(e.toString()));
    }
  }
  // Future<void> ordereHandel({List <OrderModel>? orders}){
    
  //        String orderNames = orders!
  //               .map((item) => item.product.name)
  //               .join(', ');
  //           String ordercount = orders
  //               .map((item) => item.count)
  //               .join(', ');
            
  //           double totalPrice = orders.fold<double>(
  //             0,
  //             (sum, item) => sum + item.totalPrice,
  //           );
  //           context.read<OrderCubit>().ordered(
  //             totalPrice: totalPrice,
  //             orderIs: orderNames,
  //             countIs: ordercount,
  //           );
  // }
  
//==============================================================================
 Future<void> finalizeOrder(List<OrderModel> orders) async {
    emit(OrderState.loading());
    try {
      final orderNames =
          orders.map((e) => e.product.name).join(', ');
      final orderCounts =
          orders.map((e) => e.count.toString()).join(', ');
      final totalPrice = orders.fold<double>(
        0,
        (sum, e) => sum + e.totalPrice,
      );

      await _orderRepo.ordered(
        totalPrice: totalPrice,
        orderIs: orderNames,
        countIs: orderCounts, 
      );

      emit(OrderState.success());
    } catch (e) {
      emit(OrderState.error(e.toString()));
    }
  }
}


