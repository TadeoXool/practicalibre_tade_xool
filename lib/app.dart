import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/data/firebase_auth_repo.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/post/presentation/pages/home_pages.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/cubits/auth_cubit.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/cubits/auth_states.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/pages/auth_pages.dart';
import 'package:practicalibre_tade_xool/themes/ligth_model.dart';

/*
APP - Root Level
Repositories: for the database        - firebase
Bloc Providers: for state management  - auth
                                      - profile
                                      post
                                      search
                                      theme
Check Auth State                      unauthenticated  auth page (login/register)
                                      authenticated  home page
*/
class MyApp extends StatelessWidget {
  // Auth repo
  final authRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Proporciona el cubit a la aplicación
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightModel,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);

            // Si el usuario no está autenticado, redirige a la página de autenticación
            if (authState is unauthenticated) {
              return const AuthPage();
            }
//AuthCubit(authRepo: authRepo)..checkAuth(),
            // Si el usuario está autenticado, redirige a la página principal
            if (authState is Authenticated) {
              return const HomePage();
            }

            // ... (código para el estado de carga)

            else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
