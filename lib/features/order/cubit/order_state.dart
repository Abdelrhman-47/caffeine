import 'package:caffeine/features/order/data/order_model.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'order_state.freezed.dart';

@freezed
abstract class OrderState with _$OrderState {
  factory OrderState.initial() = OrderInitial;
  factory OrderState.loading() = OrderLoading;
  factory OrderState.success() = OrderSuccess;
  factory OrderState.error(String message) = OrderError;
  factory OrderState.loaded({required List<OrderModel> orders}) = OrderLoaded;
}


