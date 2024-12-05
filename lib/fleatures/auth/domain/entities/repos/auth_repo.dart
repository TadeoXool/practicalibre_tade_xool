/*

auth Repository out Lines the possible auth oprations for this app

*/

import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/app_user.dart';

abstract class AuthRepo{
  Future<AppUser?> loginWithEmailPassword(String email,String password);
  Future<AppUser?> registerWithEmailPassword(String name,String email,String password);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}