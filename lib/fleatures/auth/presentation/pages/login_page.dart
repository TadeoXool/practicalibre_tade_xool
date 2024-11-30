/*
LOGIN  PAGE 

On this page, an existing user can login with their:
 -email
 -pw

-------------------------------------------------- 
Once the user succesfully logs in, they will be redirected to hine page.

If user dosen´t have an occout yet, they can go to register page form here to create


  */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/conponents/my_button.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/conponents/my_text_field.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  void login() {
    // Prepara el correo electrónico y la contraseña
    final String email = emailController.text;
    final String pw = pwController.text;

    // Obtiene la instancia del AuthCubit
    final authCubit = context.read<AuthCubit>();

    // Verifica que los campos de correo electrónico y contraseña no estén vacíos
    if (email.isNotEmpty && pw.isNotEmpty) {
      // Iniciar sesión
      authCubit.login(email, pw);
    } else {
      // Mostrar un mensaje de error si alguno de los campos está vacío
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  //Build UI
  @override
  Widget build(BuildContext context) {
    //SCAFOLD
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(
                  height: 50,
                ),

                //Welcome back msg
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),
                //pw textfield
                MyTextField(
                  controller: pwController,
                  hintText: "PaswsWord",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),

                //login button
                MyButton(
                  onTap: login,
                  text: "Login",
                ),

                const SizedBox(
                  height: 50,
                ),
                //not a member= register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
