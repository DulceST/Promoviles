import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pms2024/provider/test_provider.dart';
import 'package:pms2024/screens/customize_theme_screen.dart';
import 'package:pms2024/screens/detail_popular_screen.dart';
import 'package:pms2024/screens/favorite_movies_screen.dart';
import 'package:pms2024/screens/home_content_screen.dart';
import 'package:pms2024/screens/home_screen.dart';
import 'package:pms2024/screens/movies_screen.dart';
import 'package:pms2024/screens/movies_screen_firebase.dart';
import 'package:pms2024/screens/onboarding_screen.dart';
import 'package:pms2024/screens/popular_screen.dart';
import 'package:pms2024/screens/profile_screen.dart';
import 'package:pms2024/screens/login_screen.dart';
import 'package:pms2024/setting/global_values.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TestProvider()),
        // otros providers si los necesitas
      ],
      child: ValueListenableBuilder(
        valueListenable: GlobalValues.selectedTheme,
        builder: (context, value, Widget) {
          return MaterialApp(
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            home: const LoginScreen(),
            theme: value,
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
              "/detailPopular": (context) => DetailPopularScreen(),
              "/moviesScreenfirebase": (context) => MoviesScreenFirebase(),
              "/favorites": (context) => FavoriteMoviesScreen()
            },
          );
        },
      ),
    );
  }
}