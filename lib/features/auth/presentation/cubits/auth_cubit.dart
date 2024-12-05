/*


Auth Cubit: State Management



*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalibre_tade_xool/features/auth/domain/entities/app_user.dart';
import 'package:practicalibre_tade_xool/features/auth/domain/entities/repos/auth_repo.dart';
import 'package:practicalibre_tade_xool/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  AuthCubit({required this.authRepo}) : super(AuthInitial());

// check if user is already authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

// get current user
  AppUser? get currentUser => _currentUser;
//login with emial + pw
  Future<void> login(String email, String pw) async {
    try {
      emit(Authloading());
      final user = await authRepo.loginWithEmailPassword(email, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

//register with email +pw
  Future<void> register(String name, String email, String pw) async {
    try {
      emit(Authloading());
      final user = await authRepo.registerWithEmailPassword(name, email, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

//logout
  Future<void> logout() async {
    authRepo.logout();
    emit(Unauthenticated());
  }
}
