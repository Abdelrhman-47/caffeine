import 'dart:async';

import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProductRepo {
  Future<Either<String, List<ProductModel>>> getAllProducts();
  Future<Either<String, List<OfferModel>>> getOffers();
  Future<Either<String, List<ProductModel>>> productByCategory(int categoryId);
  Future<Either<String, List<ProductModel>>> productBySearch(String query);
}

class ProductRepoImpl implements ProductRepo {
  ProductRepoImpl({required ApiServices apiServices})
      : _apiServices = apiServices;

  final ApiServices _apiServices;


  @override
  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      final response = await _apiServices.get('products');

      final products = response
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }

  
  @override
  Future<Either<String, List<ProductModel>>> productByCategory(int categoryId) async{
      try {
      final response = await _apiServices.get('products?category=eq.${categoryId}');

      final products = response
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  
  }
  @override
  Future<Either<String, List<ProductModel>>> productBySearch(String query) async{


      try {
      final response = await _apiServices.get('products?name=ilike.%$query%');

      final products = response
          .map<ProductModel>((e) => ProductModel.fromJson(e))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  
  }
    Future<Either<String, List<OfferModel>>> getOffers() async {
    try {
      final response = await _apiServices.get('offer');

      final products = response
          .map<OfferModel>((e) => OfferModel.fromJson(e))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
