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
  State<HomeScreen> createState() =>
      _HomeScreenState(); // está asociada a un widget HomeScreen
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0; //controla la pantalla que se muestra actualmente
  final _key = GlobalKey<
      ExpandableFabState>(); //Se utiliza para identificar y manipular un ExpandableFab

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context)
        .size
        .width; //obtiene el ancho de la pantalla mediante MediaQuery, lo que permite ajustar el diseño según el tamaño de la pantalla.

    //Inicio del Scaffold
    return Scaffold(
      //Inicio Appbar es la barra se que muestra en la parte de arriba
      appBar: AppBar(
        backgroundColor: ColorsSettings.navColor, //color de fondo del appbar
        //Actios es el listado de widgets que se mostraran en el extremo derecho
        actions: [
          IconButton(
              // representa un botón con un ícono.
              onPressed: () {},
              icon: const Icon(Icons.location_on)),
          GestureDetector(
              //detecta gestos como toques, arrastres y deslizamientos en imagenes.
              onTap: () {}, //define lo que sucede cuando se toca la imagen.
              child: MouseRegion(
                  //permite cambiar el cursor cuando el mouse está sobre él.
                  cursor:
                      SystemMouseCursors.click, //Cambia el cursor a una mano
                  child:
                      Image.asset('assets/gato.png', width: screenWidth * 0.1)))
        ],
      ),
      //Fin del AppBar
      drawer: myDrawer(), //Agregamos el drawer para que aparezca el menu lateral
      //Inicio body para decisiones del menu de abajo
      body: Builder(
        builder: (context) {
          return LayoutBuilder(
            builder: (context, constraints) {
              switch (index) {
                case 1:
                  return const ProfileScreen(); //Opcion del centro
                default:
                  return const Home(); //Primera opcion
              }
            },
          );
        },
      ),
      //Fin del body

      //Inicio Menu de inferior 
      bottomNavigationBar: ConvexAppBar(
        //widget que proporciona una barra de navegación en la parte inferior de la pantalla.
        items: const [
          //define una lista de TabItem que representan las pestañas que aparecerán en la barra de navegación
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        onTap: (int i) => setState(() {
          //Este callback se ejecuta cuando el usuario toca un elemento en la barra de navegación.
          index = i;
        }),
      ),
      //Fin menu inferior

      //Inicio botones para cambio de tema
      floatingActionButtonLocation: ExpandableFab
          .location, //especifica la ubicación del botón de acción flotante.
      floatingActionButton: ExpandableFab(key: _key, children: [
        //define el botón de acción flotante. ExpandableFab es un tipo de botón de acción que, al ser presionado, puede desplegar otros botones asociados.
        //Inicio Cambio de color, activa el tema claro
        FloatingActionButton.small(
            //
            onPressed: () {
              GlobalValues.banThemeDark.value = false;
            },
            child: const Icon(Icons.light_mode)),
        //Fin Cambio de color, activa el tema claro
        //Inicio Cambio de color, activa el tema oscuro
        FloatingActionButton.small(
            onPressed: () {
              GlobalValues.banThemeDark.value = true;
            },
            child: const Icon(Icons.dark_mode)),
        //Fin Cambio de color, activa el tema oscuro
      ]),
      //fin botones para cambio de tema
    );
  }

  //Inicio del menu lateral
  Widget myDrawer() {
    return Drawer(
      //Crea un panel deslizable que se puede abrir desde un lado de la pantalla
      child: ListView(
        //Contiene una lista de elementos
        children: [
          const UserAccountsDrawerHeader(
            // representa un encabezado que muestra información de la cuenta del usuario.
            currentAccountPicture: CircleAvatar(
              //e utiliza para mostrar una imagen circular del usuario.
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            accountName: Text(
                'Dulce Dolores Silva Torres'), //es el nombre del usuario que se muestra debajo de la imagen.
            accountEmail: Text(
                'silvadulce541@gmail.com'), // muestra la dirección de correo electrónico del usuario.
          ),
          ListTile(
            //Se utiliza para presentar una opción de navegación.
            onTap: () => Navigator.popAndPushNamed(context,
                '/db'), //Cuando el usuario toca este elemento, se ejecuta esta función.
            title: const Text(
                'Movies List'), //es el texto que se muestra en el ListTile
            subtitle: const Text(
                'Data base of movies'), //proporciona información adicional
            leading: const Icon(
                Icons.movie), // ícono que se muestra a la izquierda del texto
            trailing: const Icon(Icons
                .chevron_right), //es un ícono que se muestra a la derecha del texto
          ),
          ListTile(
             onTap: () => Navigator.popAndPushNamed(context,
                '/homeP1'), //Cuando el usuario toca este elemento, se ejecuta esta función.
            title: const Text(
                'Practica 1'), //es el texto que se muestra en el ListTile
            subtitle: const Text(
                'Practica challenge coffe app'), //proporciona información adicional
            leading: const Icon(
                Icons.pets_rounded), // ícono que se muestra a la izquierda del texto
            trailing: const Icon(Icons
                .chevron_right),
          )
        ],
      ),
    );
    //Fin del menu lateral
  }
}
