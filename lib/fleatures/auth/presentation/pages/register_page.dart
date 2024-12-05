import 'package:flutter/material.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/conponents/my_button.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/conponents/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function ()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
final nameController = TextEditingController();
final emailController = TextEditingController();
final pwController = TextEditingController();
final confirmPwController = TextEditingController();

//register button pressed
void register(){
  // prepare info
  final String name= nameController.text;
  final String email= emailController.text;
  final String pw = pwController.text;
  final String confirmPw= confirmPwController.text;

  // autgh cubit
  final authCubit = context.read<AuthCubit>();

  // ensure the fiels arent empty
  if (email.isNotEmpty && 
  name.isNotEmpty && 
  pw.isNotEmpty && 
  confirmPw.isNotEmpty){

    //ensure passwords match
    if (pw == confirmPw){
      authCubit.register(name, email, pw);
    }

    //password dont match
    else{
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content:Text("Passwords do not match")));
    }
  }

  //fields are empty -> display error
  else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content:Text("Pleas complete all fiels")));
  }
  }
@override
void dispose() {
  nameController.dispose();
  emailController.dispose();
  pwController.dispose();
  confirmPwController.dispose();
  super.dispose();
}

// BUILD UI
  @override
  Widget build(BuildContext context) {

    //SCAFFOLD
    return ConstrainedScaffold(

      // BODY
      body:SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[ 
            
            //logo
            Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            
              ),
              const SizedBox(height:50),
              //create account message
              Text("Let's create an account for you",
              style : TextStyle(color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
               ),
              ),

              const SizedBox(height: 25),
              //Name textfield
              MyTextField(
              controller: nameController, 
              hintText: "Name",
              obscureText: false,
               ),
              const SizedBox(height: 25),
              //email textfield
              MyTextField(
              controller: emailController, 
              hintText: "Email",
              obscureText: false,
               ),

              const SizedBox(height: 10),
            
              //pw textfield
              MyTextField(
              controller: pwController, 
              hintText: "Password",
              obscureText: true,
               ),

              const SizedBox(height: 10),
            
              //confirm pw textfield
              MyTextField(
              controller: confirmPwController, 
              hintText: "Confirm Password",
              obscureText: true,
               ),
              
              const SizedBox(height: 25),
              
              // Register button
              MyButton(
                onTap: register, 
              text: "Register",
              ),
              const SizedBox(height: 8),
              //already a  member? login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?", 
                  style: 
                  TextStyle(color: Theme.of(context).colorScheme.primary )
                  ),
                  GestureDetector(
                    onTap:widget.togglePages, 
                    child: Text(
                      "Login Now", 
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ],
              ),
             ],
            ),
          ),
        ),
      ),
    );
  }
}