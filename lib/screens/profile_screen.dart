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
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Datos del perfil
  final String name = 'Dulce Silva';
  final String email = 'Dulce Silva@gmail.com';
  final String phone = '+1234567890';
  final String github = 'https://github.com/DulceST';

  final double profileCompletion = 0.8;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); 
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('No se pudo abrir la URL: $url');
    }
  }


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
            
            // Imagen de perfil
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : const AssetImage('assets/perfil.jpg') as ImageProvider,
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 50, color: Colors.white):null,
              ),
            ),
            //Fin imagen de perfil


            SizedBox(height: 20),

            // Barra de porcentaje a la derecha
                Column(
                  children: [
                    const Text(
                      'Completitud del perfil',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              margin: EdgeInsets.symmetric(vertical: 10),
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
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.phone, color: Colors.blue),
                title: GestureDetector(
                  onTap: () => _launchURL('tel:$phone'),
                  child: Text(phone, style: TextStyle(color: Colors.blue)),
                ),
              ),
            ),

            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.code, color: Colors.blue),
                title: GestureDetector(
                  onTap: () => _launchURL(github),
                  child: Text(github, style: TextStyle(color: Colors.blue)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
