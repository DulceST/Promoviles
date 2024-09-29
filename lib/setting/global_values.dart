import 'package:flutter/material.dart';
import 'package:pms2024/setting/theme_settings.dart';

class GlobalValues {
  static ValueNotifier<ThemeData> selectedTheme = ValueNotifier(ThemeSettings.lightTheme());
}