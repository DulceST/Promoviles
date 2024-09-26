import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme() {
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color(0xFFFDFDFD), // Color claro sólido
    );
  }

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color(0xFF000000), // Color oscuro sólido
    );
  }

  static ThemeData warmTheme() {
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: const Color(0xFFFFF3E0), // Fondo cálido
      primaryColor: Colors.orange, // Color primario cálido
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepOrange, // Color del AppBar
        foregroundColor: Colors.white, // Color de texto e íconos
      ),
      
    );
  }
}

