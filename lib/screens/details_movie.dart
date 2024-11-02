import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pms2024/models/moviesDAO.dart';

class DetailsMovie extends StatefulWidget {
  const DetailsMovie({super.key, required this.moviesDAO});
  final MoviesDAO moviesDAO;

  @override
  State<DetailsMovie> createState() => _DetailsMovieState();
}

class _DetailsMovieState extends State<DetailsMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              widget.moviesDAO.imgMovie ??'https://i.etsystatic.com/18242346/r/il/933afb/6210006997/il_570xN.6210006997_9fqx.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Efecto de difuminado
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
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
