import 'package:caffeine/features/cart/data/cart_model.dart';
import 'package:caffeine/features/order/cubit/order_state.dart';
import 'package:caffeine/features/order/data/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;

  OrderCubit({required OrderRepo orderRepo})
    : _orderRepo = orderRepo,
      super(OrderInitial());

  Future<void> placeOrder({
    required int count,
    required double itemPrice,
    required int productId,
    required double totalPrice,
  }) async {
    emit(OrderLoading());
    try {
      await _orderRepo.placeOrder(
        count: count,
        itemPrice: itemPrice,
        productId: productId,
        totalPrice: totalPrice,
      );

      emit(OrderSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> getUserOrders() async {
    emit(OrderLoading());
    try {
      final orders = await _orderRepo.getUserOrders();
      emit(OrderLoaded(orders: orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> deleteall() async {
    emit(OrderLoading());
    try {
      await _orderRepo.deleteall();
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  double calculateTotalPrice(List<dynamic> orders) {
    return orders.fold<double>(0, (sum, order) => sum + order.totalPrice);
  }

  Future<void> confirmCartOrders({
    required List<CartModel> cartItems,
    required Map<int, int> productCounts,
  }) async {
    emit(OrderLoading());

    try {
      for (var item in cartItems) {
        final count = productCounts[item.product.id] ?? 1;
        if (count > 0) {
          await placeOrder(
            count: count,
            itemPrice: item.realPrice,
            productId: item.product.id,
            totalPrice: item.realPrice * count,
          );
        }
      }

      emit(OrderSuccess());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
