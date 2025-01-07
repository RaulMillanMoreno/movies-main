// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:get/get.dart'; 
import 'package:movies/screens/main.dart';

void main() {
  runApp(const MyApp()); // Llama a la función para ejecutar la aplicación Flutter.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor de MyApp, sin estado mutable.

  @override
  Widget build(BuildContext context) {
    // Establece el color de la barra de estado del sistema.
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF242A32), 
      ),
    );
    
    return GetMaterialApp(  // Usamos GetMaterialApp para habilitar GetX.
      debugShowCheckedModeBanner: false,
      theme: ThemeData( // Definición del tema global de la aplicación.
        scaffoldBackgroundColor: const Color(0xFF242A32), 
        textTheme: const TextTheme( // Define la apariencia del texto en la app.
          bodyLarge: TextStyle(
            color: Colors.white, 
            fontFamily: 'Poppins', 
          ),
          bodyMedium: TextStyle(
            color: Colors.white, 
            fontFamily: 'Poppins', 
          ),
        ),
      ),
      home: Main(), // Define la pantalla inicial de la aplicación.
    );
  }
}
