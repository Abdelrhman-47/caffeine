import 'dart:developer';
import 'package:caffeine/core/network/api_services.dart';
import 'package:caffeine/features/profile/data/local_service.dart';
import 'package:caffeine/features/profile/data/user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserDataRepository {
  Future<Either<String, UserData>> getUserData();
  Future<Either<String, void>> updateProfile({
    required String name,
    required String imageUrl,
  });
}

class UserDataRepositoryImpl implements UserDataRepository {
  UserDataRepositoryImpl({
    required ApiServices apiServices,
    required LocalServiceProfile localService,
  }) : _apiServices = apiServices,
       _localService = localService;

  final ApiServices _apiServices;
  final LocalServiceProfile _localService;

  static const String _usersTable = 'users';

  String? get _currentUserId => Supabase.instance.client.auth.currentUser?.id;

  @override
  Future<Either<String, UserData>> getUserData() async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left('User not authenticated');
      }
      final response = await _apiServices.get(
        '$_usersTable?user_id=eq.$userId',
      );
      if (response.isEmpty) {
        return const Left('User data not found');
      }
      final userData = UserData.fromJson(response[0]);
      await _localService.saveUserData(userData);

      return Right(userData);
    } catch (e) {
      final _cashed = _localService.getUserData();
      if (_cashed != null) {
        return right(_cashed);
      }
      return left('Failed to fetch user data: ${e.toString()}');
    }
  }

  @override
  Future<Either<String, void>> updateProfile({
    required String name,
    required String imageUrl,
  }) async {
    try {
      final userId = _currentUserId;
      if (userId == null) {
        return const Left('User not authenticated');
      }

      if (name.trim().isEmpty) {
        return const Left('Name cannot be empty');
      }

      log('Updating profile - Name: $name, Image URL: $imageUrl');

      // Update user profile in database
      await _apiServices.patch('$_usersTable?user_id=eq.$userId', {
        'name': name,
        'image_url': imageUrl,
      });

      log('Profile updated successfully');
      return const Right(null);
    } catch (e) {
      log('Error updating profile: $e');
      return Left(_handleError(e));
    }
  }

  /// Handles and formats error messages
  String _handleError(dynamic error) {
    if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    }
    return error.toString();
  }
}
