
import 'package:equatable/equatable.dart';

abstract class RealPriceState extends Equatable {
  const RealPriceState();

  @override
  List<Object> get props => [];
}
final class RealPriceInitial extends RealPriceState {}


final class RealPriceChanged extends RealPriceState {
  final double realPrice;

  const RealPriceChanged(this.realPrice);

  @override
  List<Object> get props => [realPrice];
}
class RealPriceNoInternet extends RealPriceState {
  final String message;
 const RealPriceNoInternet(this.message);
  @override
  List<Object> get props => [message];
}
final class RealPriceLoading extends RealPriceState {}

final class RealPriceError extends RealPriceState {
  final String message;

  const RealPriceError(this.message);

  @override
  List<Object> get props => [message];
}
