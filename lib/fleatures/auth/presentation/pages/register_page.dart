import 'package:flutter/material.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/conponents/my_button.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/conponents/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirPwController = TextEditingController();

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

                //create acount message
                Text(
                  "Let´s create an account for you",
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
                  controller: nameController,
                  hintText: "Name",
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

                //confirm pw textfield
                MyTextField(
                  controller: confirPwController,
                  hintText: "Confirm PaswsWord",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),

                //Register button
                MyButton(
                  onTap: () {},
                  text: "Register",
                ),

                const SizedBox(
                  height: 50,
                ),
                // already a member= register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a now?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "login now",
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
