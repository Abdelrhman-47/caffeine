import 'package:caffeine/features/order/data/order_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded({required this.orders});
}
