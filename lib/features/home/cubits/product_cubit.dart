import 'dart:async';

import 'package:caffeine/features/home/cubits/product_state.dart';
import 'package:caffeine/features/home/data/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required ProductRepo productRepo})
      : _productRepo = productRepo,
        super(ProductInitial());
  final ProductRepo _productRepo;
    Timer? _debounce;

  Future<void> getAllProducts() async {
    emit(ProductLoading());
    final result = await _productRepo.getAllProducts();
    result.fold((l)=>emit(ProductFailure(l)), (r)=>emit(ProductSuccess(r)));

  }

  Future<void> ProductsByCategory(int categoryId) async {
    emit(ProductLoading());
    final result = await _productRepo.productByCategory(categoryId);
    result.fold((l)=>emit(ProductFailure(l)), (r)=>emit(ProductSuccess(r)));

  }
   Future<void> ProductsBySearch(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 900), () async {
      if (query.isEmpty) {
        emit(ProductInitial());
        return;
      }

      emit(ProductLoading());
      final result = await _productRepo.productBySearch(query);
      result.fold((l) => emit(ProductFailure(l)), (r) => emit(ProductSuccess(r)));
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

