// import 'package:caffeine/core/network/api_services.dart';
// import 'package:caffeine/features/favorite/data/fav_model.dart';
// import 'package:caffeine/features/home/data/product_model.dart';
// import 'package:dartz/dartz.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// abstract class FavRepo {
//   Future<Either<String, List<ProductsModel>>> getFavProducts();
//   Future<void> addFavProduct(int productId, bool isFav);
// }

// class FavRepoImpl implements FavRepo {
//   final supabase = Supabase.instance.client;

//   final ApiServices _apiServices;

//   FavRepoImpl({required ApiServices apiServices})
//     : _apiServices = apiServices;
//   @override
//   Future<Either<String, List<ProductsModel>>> getFavProducts() async {
//     Map<String, dynamic> queryParameters = {
//       'select': '*,products(*)',
//       'user_id': 'eq.${supabase.auth.currentUser!.id}',
//       'is_fav': 'eq.true',
//     };

//     try {
//       final response = await _apiServices.get(
//         'fav',
//         queryParameters: queryParameters,
//       );

//       if (response is List) {
//         final List<ProductsModel> products = response
//             .map<ProductsModel>((e) {
//               final fav = FavModel.fromJson(e);
//               return fav.product;
//             })
//             .toList();
//         return Right(products);
//       } else {
//         return Left('Invalid response format');
//       }
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
  
//   @override
//   Future<void> addFavProduct(int productId, bool isFav) async{
//     final body={
//       'user_id':supabase.auth.currentUser!.id,
//       'product_id':productId,
//       'is_fav':isFav
//     };
// await _apiServices.post('fav', body) ;
//   }

// }
import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/features/favorite/data/fav_model.dart';
import 'package:caffeine/features/home/data/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FavRepo {
  Future<Either<String, List<FavModel>>> getFavProducts();
  Future<void> addFavProduct(int productId);
  Future<void> removeFavProduct(int productId);
}

class FavRepoImpl implements FavRepo {
  final supabase = Supabase.instance.client;
  final ApiServices _apiServices;

  FavRepoImpl({required ApiServices apiServices})
      : _apiServices = apiServices;

  @override
  Future<Either<String, List<FavModel>>> getFavProducts() async {
    Map<String, dynamic> queryParameters = {
      'select': '*,products(*)',
      'user_id': 'eq.${supabase.auth.currentUser!.id}',
      'is_fav': 'eq.true',
    };

    try {
      final response = await _apiServices.get(
        'fav',
        queryParameters: queryParameters,
      );

      if (response is List) {
        final List<FavModel> favsData = response
            .map<FavModel>((e) {
              final favData = FavModel.fromJson(e);
              return favData;
            })
            .toList();
        return Right(favsData);
      } else {
        return Left('Invalid response format');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> addFavProduct(int productId) async {
    try {
      final body = {
        'user_id': supabase.auth.currentUser!.id,
        'product_id': productId,
        'is_fav': true,
      };
      await _apiServices.post('fav', body);
    } catch (e) {
      try {
        final checkParams = {
          'select': 'id',
          'user_id': 'eq.${supabase.auth.currentUser!.id}',
          'product_id': 'eq.$productId',
        };

        final existingRecords = await _apiServices.get(
          'fav',
          queryParameters: checkParams,
        );

        if (existingRecords is List && existingRecords.isNotEmpty) {
            final body = {
        'user_id': supabase.auth.currentUser!.id,
        'product_id': productId,
        'is_fav': true,
      };
          final recordId = existingRecords[0]['id'];
          // Delete and recreate (workaround if no PATCH method)
          await _apiServices.delete('fav?id=eq.$recordId');
          await _apiServices.post('fav', body);
        }
      } catch (e2) {
        throw Exception('Failed to update favorite: $e2');
      }
    }
  }
  
  @override
  Future<void> removeFavProduct(int productId) async{
    await _apiServices.delete('fav?product_id=eq.$productId');
  
  }
}

