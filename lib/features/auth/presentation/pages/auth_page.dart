/*

Auth Page - This page determines wheter to show the login or register page

*/

import 'package:flutter/material.dart';
import 'package:practicalibre_tade_xool/features/auth/presentation/pages/login_page.dart';
import 'package:practicalibre_tade_xool/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  //initially,show login page
  bool showLoginPage = true;
  // tooglle between pages
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
