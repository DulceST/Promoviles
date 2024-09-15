import 'package:flutter/material.dart';

class MyClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.5); // Derecho arriba
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.5);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
