import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pms2024/screens/customize_theme_screen.dart';
import 'package:pms2024/screens/detail_popular_screen.dart';
import 'package:pms2024/screens/home_content_screen.dart';
import 'package:pms2024/screens/home_screen.dart';
import 'package:pms2024/screens/movies_screen.dart';
import 'package:pms2024/screens/movies_screen_firebase.dart';
import 'package:pms2024/screens/onboarding_screen.dart';
import 'package:pms2024/screens/popular_screen.dart';
import 'package:pms2024/screens/profile_screen.dart';
import 'package:pms2024/screens/login_screen.dart';
import 'package:pms2024/setting/global_values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pms2024/screens/home.dart';

//que inicia la aplicación Flutter y toma un widget como argumento, en este caso, MyApp
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   try {
    await Firebase.initializeApp();
    print("Firebase se ha inicializado correctamente."); // Mensaje de consola
  } catch (e) {
    print("Error al inicializar Firebase: $e"); // Mensaje de error si falla
  }
  
  // Cargar el estado del Onboarding antes de iniciar la app
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingSeen = prefs.getBool('onboardingSeen') ?? false;

  runApp(MyApp(onboardingSeen: onboardingSeen));
}

class MyApp extends StatelessWidget {
  final bool onboardingSeen; // Recibe el estado de si el onboarding ya fue visto

  const MyApp({super.key, required this.onboardingSeen});

//El método build se llama cada vez que se necesita construir la interfaz
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.selectedTheme,
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        builder: (context, value, Widget) {
          //es el widget principal de la aplicación que proporciona el diseño y la funcionalidad de Material Design
          return MaterialApp(
            title: 'Material App', //Establece el título de la aplicación.
            debugShowCheckedModeBanner:
                false, // Desactiva la etiqueta de depuración que aparece en la esquina superior derecha
            home://onboardingSeen
            const LoginScreen(),
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
              "/login": (context) => const LoginScreen(),
              "/onboarding": (context) => const OnboardingScreen(),
              "/homeProduct": (context) => Home(),
              "/moviesScreen": (context) => MoviesScreen(),
              "/popular": (context) => PopularScreen(),
              "/detail": (context) => DetailPopularScreen(),
              "/moviesScreenfirebase": (context) => MoviesScreenFirebase()
            
            },
          );
        });
  }
}
