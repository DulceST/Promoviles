import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData LightTheme(){
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(3, 255, 193, 7),
      
    );

  }
  static ThemeData darkTheme(){
    final theme = ThemeData.dark();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(210, 107, 104, 96),
    );
    
  }

  static ThemeData warmTheme(){
    final theme = ThemeData.light();
    return theme.copyWith();
  }
}