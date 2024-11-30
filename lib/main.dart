import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practicalibre_tade_xool/app.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/pages/auth_pages.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/pages/login_page.dart';
import 'package:practicalibre_tade_xool/fleatures/auth/presentation/pages/register_page.dart';
import 'package:practicalibre_tade_xool/themes/ligth_model.dart';
import 'firebase_options.dart';

void main() async {
  // Firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Run app
  runApp(MyApp());
}
