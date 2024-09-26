import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image; //Almacena la imagen seleccionada
  final ImagePicker _picker = ImagePicker(); // Inicializamos el ImagePicker

  // Datos del perfil
  final String name = 'Dulce Silva';
  final String email = 'silvadulce541@gmail.com';
  final String phone = '+1234567890';
  final String github = 'https://github.com/DulceST';

  final double profileCompletion = 0.8;

//Inicio seleccion fotos de la galeria
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery); //abre la galeria y permite seleccionar
    setState(() {
      //sirve para actualizar la imagen
      if (image != null) {
        //Si se selecciona una imagen, se guarda en la variable
        _image = File(image.path);
      }
    });
  }
  //Fin seleccion fotos de la galeria

  //Inicio tomar fotos
  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }
  //Fin tomar fotos

//Inicio abrir URL
  Future<void> _launchURL(String url) async {
    final Uri uri =
        Uri.parse(url); //toma la cadena y la cobvierte a un objeto Uri
    if (await canLaunchUrl(uri)) {
      //verififca si existe la aplicacion en el dispositivo
      await launchUrl(uri); //si canLaunchUrl es true abre el URL
    } else {
      print('No se pudo abrir la URL: $url');
    }
  }
  //Fin abrir URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          //Inicio Fondo
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        //Fin fondo

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Inicio Imagen de perfil
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text('Tomar una foto'),
                              onTap: () {
                                _takePhoto(); // Función para tomar una foto
                                Navigator.pop(context); // Cierra el BottomSheet
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Seleccionar de la galería'),
                              onTap: () {
                                _pickImage(); // Función para seleccionar una imagen de la galería
                                Navigator.pop(context); // Cierra el BottomSheet
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/perfil.jpg')
                            as ImageProvider,
                  ),
                ),
                //Fin imagen de perfil

                const SizedBox(height: 20),

                // Inicio Barra de porcentaje a la derecha
                Column(
                  children: [
                    const Text(
                      'Completitud del perfil',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CircularPercentIndicator(
                      radius: 75.0,
                      lineWidth: 8.0,
                      percent: profileCompletion,
                      center: Text("${(profileCompletion * 100).toInt()}%"),
                      progressColor: const Color.fromARGB(255, 212, 166, 234),
                      backgroundColor: Colors.grey[300] ?? Colors.grey,
                    ),
                  ],
                ),
              ],
            ),

            Text(name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            //Inicio Tarjetas para la informacion del email
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.email, color: Colors.blue),
                title: GestureDetector(
                  onTap: () => _launchURL('mailto:$email'),
                  child:
                      Text(email, style: const TextStyle(color: Colors.blue)),
                ),
              ),
            ),
            //Fin Tarjetas para la informacion del email

            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.phone, color: Colors.blue),
                title: GestureDetector(
                  onTap: () => _launchURL('tel:$phone'),
                  child:
                      Text(phone, style: const TextStyle(color: Colors.blue)),
                ),
              ),
            ),

            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.code, color: Colors.blue),
                title: GestureDetector(
                  onTap: () => _launchURL(github),
                  child:
                      Text(github, style: const TextStyle(color: Colors.blue)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
