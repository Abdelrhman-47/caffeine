

import 'package:caffeine/features/home/cubits/offers_cubit/offers_state.dart';
import 'package:caffeine/features/home/data/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit({required ProductRepo productRepo}) :_productRepo=productRepo, super(OfferInitial());
final ProductRepo _productRepo;
   Future<void> getOffers() async {
    emit(OffertLoading());
    final result = await _productRepo.getOffers();
    result.fold((l)=>emit(OfferFailure(l)), (r)=>emit(OfferSuccess(r)));

  }
}
