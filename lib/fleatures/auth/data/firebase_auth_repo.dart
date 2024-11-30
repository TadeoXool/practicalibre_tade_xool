import 'package:firebase_auth/firebase_auth.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/app_user.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/domain/entities/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser> loginWhithEmailPassword(String email, String paswword) async {
    try {
      // attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: paswword);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      // return user
      return user;
    }
    // catch any errors..
    catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser> resgisterWhithEmailPassword(
      String name, String email, String paswword) async {
    try {
      // attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: paswword);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // return user
      return user;
    }
    // catch any errors..
    catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // Código adicional aquí para obtener el usuario actual
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
  }
}
