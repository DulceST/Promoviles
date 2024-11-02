import 'dart:ui';

import 'package:flutter/material.dart';

class DetailsMovie extends StatelessWidget {
  const DetailsMovie({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo difuminada
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Efecto de difuminado
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4), // Ajusta la opacidad
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.2), // Difumina un poco más
                ),
              ),
            ),
          ),
          // Otros contenidos de la página
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Detalles de la Película',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                // Otros detalles
              ],
            ),
          ),
        ],
      ),
    );
  }
}
