/*

Auth States

*/

import 'package:flutter/material.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/app_user.dart';

abstract class AuthState {}

// initial 
class AuthInitial extends AuthState{}

// loading..
class Authloading extends AuthState{}



//authenticated
class Authenticated extends AuthState{
  final AppUser user;
  Authenticated(this.user);
}
//unauthenticated
class Unauthenticated extends AuthState{} 
//error..
class AuthError extends AuthState{
  final String  message;
  AuthError(this.message);
}
//git branch --set-upstream-to=origin/main main
