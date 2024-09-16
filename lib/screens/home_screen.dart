import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pms2024/screens/profile_screen.dart';
import 'package:pms2024/screens_P1/home.dart';
import 'package:pms2024/setting/colors_settings.dart';
import 'package:pms2024/setting/global_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.access_alarm_outlined)),
          GestureDetector(
              onTap: () {},
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset('assets/gato.png')))
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (index) {
            case 1:
              return const ProfileScreen();//Opcion del centro
            default:
              return const Home();//Primera opcion
          }
        },
      ),
      //Menu lateral izquierdo
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children:  <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 188, 250),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Color.fromARGB(255, 2, 2, 2),
                  fontSize: 15,
                ),
              ),
            ),
            ListTile(
              title: const Text('Sylvanian Families'),
              onTap:(){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        onTap: (int i) => setState(() {
          index = i;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(key: _key, children: [
        FloatingActionButton.small(
            onPressed: () {
              GlobalValues.banThemeDark.value = false;
            },
            child: const Icon(Icons.light_mode)),
        FloatingActionButton.small(
            onPressed: () {
              GlobalValues.banThemeDark.value = true;
            },
            child: const Icon(Icons.light_mode_outlined)),
      ]),
    ); //para que no se vea la pantalla en blanco
  }
}
