import 'dart:developer';

import 'package:caffeine/features/details/cubit/real_price_state.dart';
import 'package:caffeine/features/details/data/details_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class RealPriceCubit extends Cubit<RealPriceState> {
  final DetailsRepo _detailsRepo;

  RealPriceCubit({required DetailsRepo detailsRepo})
      : _detailsRepo = detailsRepo , super(RealPriceInitial());
       double _realPrice = 0;

  double get realPrice => _realPrice;
Future<void> getPrice(String size,int productId)async{
  emit(RealPriceLoading());
  try {
    final price=await _detailsRepo.getPrice(size, productId);
    _realPrice=price.realPrice;
    log('${price.realPrice}');
    emit(RealPriceChanged(price.realPrice));
  } catch (e) {
    emit(RealPriceError(e.toString()));
  }
}

}
