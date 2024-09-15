import 'package:flutter/material.dart';

class Product {
  String name; 
  String conName;
  String backgroundImage;
  String produImage;
  String description; 
  Color lightColor;
  Color darkColor;

  Product(this.name, this.conName, this.backgroundImage,this.produImage,
   this.description, this.lightColor, this.darkColor);
}