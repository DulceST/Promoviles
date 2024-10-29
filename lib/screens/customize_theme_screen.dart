import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pms2024/setting/global_values.dart'; // Ajusta esta ruta según tu proyecto

class CustomizeThemeScreen extends StatefulWidget {
  const CustomizeThemeScreen({super.key});

  @override
  State<CustomizeThemeScreen> createState() => _CustomizeThemeScreenState();
}

class _CustomizeThemeScreenState extends State<CustomizeThemeScreen> {
  late Color _scaffoldBackgroundColor;
  late Color _appBarColor;
  late Color _floatingActionButtonColor;
  late Color _bottomNavigationBarColor;
  String _selectedFont = 'Roboto';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Inicializa los colores con los valores actuales del tema
    final theme = Theme.of(context);
    _scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    _appBarColor = theme.appBarTheme.backgroundColor ?? Colors.blue; // Si el color no está definido, usa un fallback
    _floatingActionButtonColor = theme.floatingActionButtonTheme.backgroundColor ?? Colors.green;
    _bottomNavigationBarColor = theme.bottomNavigationBarTheme.backgroundColor ?? Colors.orange;
  }

  Future<void> _pickColor(BuildContext context, Color currentColor, Function(Color) onColorSelected) async {
  Color selectedColor = currentColor; // Inicializa con el color actual
  selectedColor = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Selecciona un color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: (color) {
              selectedColor = color; // Actualiza el color seleccionado mientras se elige
            },
            // ignore: deprecated_member_use
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(selectedColor); // Retorna el color seleccionado
            },
          ),
        ],
      );
    },
  ) ?? currentColor; // Si se cierra el diálogo sin seleccionar, usa el color actual

  // Asegúrate de que el color seleccionado se aplique
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
              trailing: Container(
                padding: const EdgeInsets.all(2), // Padding para el borde
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2), // Borde negro
                ),
                child: CircleAvatar(
                  backgroundColor: _scaffoldBackgroundColor,
                ),
              ),
              onTap: () => _pickColor(context, _scaffoldBackgroundColor, (color) {
                setState(() {
                  _scaffoldBackgroundColor = color;
                });
              }),
            ),
            ListTile(
              title: const Text('Color de la barra superior'),
              trailing: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: CircleAvatar(
                  backgroundColor: _appBarColor,
                ),
              ),
              onTap: () => _pickColor(context, _appBarColor, (color) {
                setState(() {
                  _appBarColor = color;
                });
              }),
            ),
            ListTile(
              title: const Text('Color del botón flotante'),
              trailing: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: _floatingActionButtonColor,
                ),
              ),
              onTap: () => _pickColor(context, _floatingActionButtonColor, (color) {
                setState(() {
                  _floatingActionButtonColor = color;
                });
              }),
            ),
            ListTile(
              title: const Text('Color de la barra de navegación inferior'),
              trailing: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: _bottomNavigationBarColor,
                ),
              ),
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
                  ),
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
