import 'package:flutter/material.dart';
import 'package:pms2024/screens/customize_theme_screen.dart';
import 'package:pms2024/screens/home_content_screen.dart';
import 'package:pms2024/screens/home_screen.dart';
import 'package:pms2024/screens/onboarding_screen.dart';
import 'package:pms2024/screens/profile_screen.dart';
//import 'package:pms2024/screens_P1/home.dart';
import 'package:pms2024/screens/login_screen.dart';
import 'package:pms2024/setting/global_values.dart';


//que inicia la aplicación Flutter y toma un widget como argumento, en este caso, MyApp
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  

//El método build se llama cada vez que se necesita construir la interfaz
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.selectedTheme,
        builder: (context, value, Widget) {
          //es el widget principal de la aplicación que proporciona el diseño y la funcionalidad de Material Design
          return MaterialApp(
            title: 'Material App', //Establece el título de la aplicación.
            debugShowCheckedModeBanner:
                false, // Desactiva la etiqueta de depuración que aparece en la esquina superior derecha
            home: const OnboardingScreen(),
                //const LoginScreen(), //Define el widget que se muestra al iniciar la aplicación, que en este caso es LoginScreen
            //Configura el tema de la aplicacion
            theme: value,
            /*? ThemeSettings.darkTheme() //Si es true muestra el tema oscuro
                : ThemeSettings
                    .lightTheme(),*/ //si es false muestra el tema claro
            //rutas para navegar
            routes: {
              "/home": (context) => const HomeScreen(),
              "/profile": (context) => const ProfileScreen(),
              "/homeContent": (context) => const HomeContentScreen(),
              "/customize": (context) => const CustomizeThemeScreen(),
              "/login": (context)=> const LoginScreen()
            },
          );
        });
  }
}
