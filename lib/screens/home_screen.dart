import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pms2024/screens/home_content_screen.dart';
import 'package:pms2024/screens/profile_screen.dart';
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
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.access_alarm_outlined)),
          GestureDetector(
              onTap: () {},
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.asset('assets/icono_comida.png')))
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (index) {
            case 0:
              return const HomeContentScreen(); // Pantalla de inicio
            case 1:
              return const ProfileScreen(); // Ejemplo: pantalla de perfil
            default:
              return const HomeContentScreen(); // Pantalla por defecto
          }
        },
      ),
      //endDrawer: Drawer(),
      drawer: myDrawer(),
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
            heroTag: "btn1",
            onPressed: () {
              GlobalValues.banThemeDark.value = false;
            },
            child: const Icon(Icons.light_mode)),
        FloatingActionButton.small(
            heroTag: "btn2",
            onPressed: () {
              GlobalValues.banThemeDark.value = true;
            },
            child: const Icon(Icons.dark_mode))
      ]),
    );
  }

  Widget myDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text('Dulce Dolores Silva Torres'),
              accountEmail: Text('@itcelaya.edu.mx')),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/db'),
            title: const Text('Movies List'),
            subtitle: const Text('Database of movies'),
            leading: const Icon(Icons.movie),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/db'),
            title: const Text('Practica 1'),
            subtitle: const Text('Practica 1: Challenge '),
            leading: const Icon(Icons.pets),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
