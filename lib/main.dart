import 'package:flutter/material.dart';
import 'package:pms2024/screens/home_screen.dart';
import 'package:pms2024/screens/profile_screen.dart';
import 'package:pms2024/screens_P1/home.dart';
import 'package:pms2024/screens/login_screen.dart';
import 'package:pms2024/setting/global_values.dart';
import 'package:pms2024/setting/theme_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.banThemeDark,
      builder: (context,value,Widget) {
        return MaterialApp(         
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home:  const LoginScreen(),
          theme: value 
          ? ThemeSettings.darkTheme() 
          : ThemeSettings.LightTheme(),
          routes: {
            "/home": (context)  =>  HomeScreen(), //correspondencia etiqeuta valor dode etiqueta es string 
            "/homeP1": (context) => Home(),
            "/profile": (context) => ProfileScreen(),
          },
        );
      }
    );
  }
}