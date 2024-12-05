/*
Auth States 
*/

import 'package:practicalibre_tade_xool/features/auth/domain/entities/app_user.dart';

abstract class AuthState {}

// initial
class AuthInitial extends AuthState {}

// loading..
class Authloading extends AuthState {}

//authenticated
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

//unauthenticated
class Unauthenticated extends AuthState {}

//error..
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
