import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practicalibre_tade_xool/config/firebase_options.dart';

import 'app.dart';

void main() async {
  //firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // run app
  runApp(MyApp());
}
