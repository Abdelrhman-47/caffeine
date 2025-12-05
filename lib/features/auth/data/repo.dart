import 'dart:developer';

import 'package:caffeine/core/helpers/pref_helpers.dart';
import 'package:caffeine/core/network/api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRepo {
  Future<Either<AuthException, User>> signUp({
    required String email,
    required String password,
     required String name,
    required String url,
  });

  Future<Either<AuthException, User>> login({
    required String email,
    required String password,
  });
  Future<void> addUserInfo(String name,String? url);
  Future<void> logout();
}

class UserRepoImplement extends UserRepo {
  final ApiServices _apiServices;
  final PrefHelpers _sharedPref;
  final SupabaseClient _supabase;
  UserRepoImplement({
    required SupabaseClient supabase,
    required PrefHelpers sharedPref,
    required ApiServices apiServices,
  }) : _supabase = supabase,
       _sharedPref = sharedPref,
       _apiServices = apiServices;

  @override
  Future<Either<AuthException, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        return left(AuthException('Login failed: No user returned'));
      }
      _sharedPref.saveToken(response.session!.accessToken);
      return right(response.user!);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthException(e.toString()));
    }
  }

  @override
  Future<Either<AuthException, User>> signUp({
    required String email,
    required String password,
    required String name,
    required String url,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      _sharedPref.saveToken(response.session!.accessToken);
      log('==========${response.session!.accessToken}===============');
       addUserInfo(name,url);
      return right(response.user!);
    } on AuthException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AuthException(e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
  
  @override
  Future<void> addUserInfo(String name,String? url) async{
    final  respnse=await _apiServices.post('users', {
 "user_id": _supabase.auth.currentUser?.id,
      "name": name,
      "email":_supabase.auth.currentUser?.email ,
      "image_url": null,

    });
  return respnse;
  }
}
