import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pms2024/setting/global_values.dart';

class CustomizeThemeScreen extends StatefulWidget {
  const CustomizeThemeScreen({super.key});

  @override
  State<CustomizeThemeScreen> createState() => _CustomizeThemeScreenState();
}

class _CustomizeThemeScreenState extends State<CustomizeThemeScreen> {
  Color _scaffoldBackgroundColor = Colors.white;
  Color _appBarColor = Colors.blue;
  Color _floatingActionButtonColor = Colors.green;
  Color _bottomNavigationBarColor = Colors.orange;
  String _selectedFont = 'Roboto';

  Future<void> _pickColor(BuildContext context, Color currentColor, Function(Color) onColorSelected) async {
    Color selectedColor = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorSelected,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(currentColor);
              },
            ),
          ],
        );
      },
    );

    onColorSelected(selectedColor);
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalizar Tema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Color de fondo de la pantalla'),
              trailing: CircleAvatar(backgroundColor: _scaffoldBackgroundColor),
              onTap: () => _pickColor(context, _scaffoldBackgroundColor, (color) {
                setState(() {
                  _scaffoldBackgroundColor = color;
                });
              }),
            ),
            ListTile(
              title: const Text('Color de la barra superior'),
              trailing: CircleAvatar(backgroundColor: _appBarColor),
              onTap: () => _pickColor(context, _appBarColor, (color) {
                setState(() {
                  _appBarColor = color;
                });
              }),
            ),
            ListTile(
              title: const Text('Color del botón flotante'),
              trailing: CircleAvatar(backgroundColor: _floatingActionButtonColor),
              onTap: () => _pickColor(context, _floatingActionButtonColor, (color) {
                setState(() {
                  _floatingActionButtonColor = color;
                });
              }),
            ),
            ListTile(
              title: const Text('Color de la barra de navegación inferior'),
              trailing: CircleAvatar(backgroundColor: _bottomNavigationBarColor),
              onTap: () => _pickColor(context, _bottomNavigationBarColor, (color) {
                setState(() {
                  _bottomNavigationBarColor = color;
                });
              }),
            ),
            ListTile(
              title: const Text('Tipo de letra'),
              trailing: DropdownButton<String>(
                value: _selectedFont,
                items: <String>['Roboto', 'Lato', 'Open Sans', 'Pacifico'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: GoogleFonts.getFont(value)),
                  );
                }).toList(),
                onChanged: (String? newFont) {
                  setState(() {
                    _selectedFont = newFont ?? 'Roboto';
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Guardar Tema Personalizado'),
              onPressed: () {
                // Aquí guardas los colores seleccionados
                GlobalValues.selectedTheme.value = ThemeData(
                  scaffoldBackgroundColor: _scaffoldBackgroundColor,
                  appBarTheme: AppBarTheme(color: _appBarColor),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: _floatingActionButtonColor,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: _bottomNavigationBarColor,
                  ),
                  textTheme: TextTheme(
                    bodyMedium: GoogleFonts.getFont(_selectedFont), 
                  )
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}