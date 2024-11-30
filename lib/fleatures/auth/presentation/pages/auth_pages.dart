/*
auth
*/
import 'package:flutter/material.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/pages/login_page.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Inicialmente, mostrar la página de login
  bool showLoginPage = true;

  // Función para alternar entre las páginas
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        togglePages: togglePages,
      );
    } else {
      return RegisterPage(
        togglePages: togglePages,
      );
    }
  }
}
