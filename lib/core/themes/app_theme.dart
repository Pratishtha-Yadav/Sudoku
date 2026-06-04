import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: const Color(0xFF070B23),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7B3FFF),
      secondary: Color(0xFF2D8CFF),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF070B23),
      elevation: 0,
    ),
  );
}