import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData dark() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: Colors.black,
      primaryColorLight: Colors.white,
      scaffoldBackgroundColor: Colors.black,
    );
  }

  static ThemeData light() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: Colors.white,
      primaryColorLight: Colors.black,
      scaffoldBackgroundColor: Colors.white,
    );
  }
}
