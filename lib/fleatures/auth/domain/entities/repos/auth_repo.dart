/*

auth Repository out Lines the possible auth oprations for this app

*/

import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser> loginWhithEmailPassword(String email, String paswword);
  Future<AppUser> resgisterWhithEmailPassword(
      String name, String email, String paswword);
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
