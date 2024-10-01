import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 254),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF8EACCD),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFB7E0FF), 
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF8EACCD),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFFB7E0FF), // Color de fondo del Drawer
      ),
      // Personalización de los elementos del Drawer
      listTileTheme: const ListTileThemeData(
        textColor: Colors.black, // Color del texto en ListTiles
        iconColor: Color(0xFF8EACCD), // Color de los iconos en ListTiles
      ),
      cardTheme: const CardTheme(
        color: Color(0xFFB7E0FF)
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xFFC9DABF),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF5F6F65),
        iconTheme: IconThemeData(
          color: Colors.white,
          
        )
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF9CA986), 
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF5F6F65),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFFDEE5D4), // Color de fondo del Drawer
      ),
      // Personalización de los elementos del Drawer
      listTileTheme: const ListTileThemeData(
        textColor: Colors.black, // Color del texto en ListTiles
        iconColor: Color(0xFF5F6F65), // Color de los iconos en ListTiles
      ),
      cardTheme: const CardTheme(
        color: Color(0xFFDEE5D4)
      ),
    );
  }
}
