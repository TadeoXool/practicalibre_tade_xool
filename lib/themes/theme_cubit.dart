import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicalibre_tade_xool/themes/dark_mode.dart';
import 'package:practicalibre_tade_xool/themes/light_mode.dart';

class ThemeCubit extends Cubit<ThemeData> {
  bool _isDarkMode = false;

  ThemeCubit() : super(lightMode);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;

    if (isDarkMode) {
      emit(darkMode);
    } else {
      emit(lightMode);
    }
  }
}
