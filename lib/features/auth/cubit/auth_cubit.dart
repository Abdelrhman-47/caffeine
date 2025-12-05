import 'dart:developer';

import 'package:caffeine/features/auth/cubit/auth_state.dart';
import 'package:caffeine/features/auth/data/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepo _user;

  AuthCubit({required UserRepo user,})
    : _user = user,
      super(const AuthInitial());
  Future signUp({required String email, required String password, required String name, required String url}) async {
    emit(AuthLoading());
    final result = await _user.signUp(email: email, password: password, name: name, url: '');
    
    log('$result');
    result.fold(
      (failure) =>
          emit(AuthFailure(error: failure.message, type: AuthType.signUp)),
      (user) => emit(
        const AuthSuccess(
          message: 'Account created successfully',
          type: AuthType.signUp,
        ),
      ),
    );
  }

  Future login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await _user.login(email: email, password: password);
        log('$result');

    result.fold(
      (failure) =>
          emit(AuthFailure(error: failure.message, type: AuthType.login)),
      (user) => emit(
        const AuthSuccess(
          message: 'Logged in successfully',
          type: AuthType.login,
        ),
      ),
    );
  }

  Future<void> logout() async {
    await _user.logout();
    emit(const AuthInitial());
  }
}
