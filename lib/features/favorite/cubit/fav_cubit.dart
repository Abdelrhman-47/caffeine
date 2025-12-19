import 'dart:developer';
import 'package:caffeine/features/favorite/cubit/fav_state.dart';
import 'package:caffeine/features/favorite/data/fav_model.dart';
import 'package:caffeine/features/favorite/data/fav_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit({required FavRepo favRepo})
      : _favRepo = favRepo,
        super(FavInitial());

  final FavRepo _favRepo;

  Future<void> getAllFavs({bool showLoading = true}) async {
    if (showLoading) emit(FavLoading());
    final result = await _favRepo.getFavProducts();
    log('result: $result');
    result.fold(
      (l) => emit(FavError(l)),
      (r) => emit(FavLoaded(r)),
    );
  }

  Future<void> addFavProduct(int productId) async {
    try {
      await _favRepo.addFavProduct(productId);
      await getAllFavs(showLoading: false);
    } catch (e) {
      emit(FavError(e.toString()));
    }
  }
  Future<void> deletFavProduct(int productId) async {
    try {
      await _favRepo.removeFavProduct(productId);
            await getAllFavs(showLoading: false);

    } catch (e) {
      emit(FavError(e.toString()));
    }
  }
}