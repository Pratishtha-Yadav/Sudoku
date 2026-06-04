import 'package:flutter/material.dart';
import '../core/themes/app_theme.dart';
import '../features/splash/splash_screen.dart';

class AdvancedSudokuApp extends StatelessWidget {
  const AdvancedSudokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      title: 'Sudoku',
      home: const SplashScreen()
    );   
  } 
}