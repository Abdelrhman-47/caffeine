import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

enum AuthType { signUp, login }
class AuthInitial extends AuthState {
  const AuthInitial();
}
class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final String message;
  final AuthType type;

  const AuthSuccess({required this.message, required this.type});
  List<Object?> get props => [message, type];
}

class AuthFailure extends AuthState {
  final String error;
  final AuthType type;

  const AuthFailure({required this.error, required this.type});

  @override
  List<Object?> get props => [error, type];
}
