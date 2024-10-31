import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  String _name = 'Dulce Dolores Silva Torres';
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }
}