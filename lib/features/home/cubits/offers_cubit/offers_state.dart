import 'package:caffeine/features/home/data/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class OffersState extends Equatable {
const OffersState();

  @override
  List<Object> get props => [];
}

final class OfferInitial extends OffersState {}

final class OffertLoading extends OffersState {}

final class OfferSuccess extends OffersState {
  final List<OfferModel> offers;

  const OfferSuccess(this.offers);

  @override
  List<Object> get props => [offers];
}

final class OfferFailure extends OffersState {
  final String errMessage;

  const OfferFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
  
}
