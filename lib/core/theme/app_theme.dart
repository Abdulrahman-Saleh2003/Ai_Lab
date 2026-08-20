import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Cairo',
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00D2FF),
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Cairo',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF111317),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF00D2FF),
        secondary: Color(0xFFEDB1FF),
        surface: Color(0xFF111317),
      ),
      textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'Cairo',
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
    );
  }
}