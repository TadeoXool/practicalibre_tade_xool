/*

Auth States

*/

import 'package:flutter/material.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/app_user.dart';

abstract class AuthState {}

// Initial
class AuthInitial extends AuthState {}

//loading...
class AuthLoading extends AuthState {}

//authenticated
class Authenticated extends AuthState {
  final AppUser user;
  Authenticated(this.user);
}

//unauthenticated
class unauthenticated extends AuthState {}

//errors...
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
