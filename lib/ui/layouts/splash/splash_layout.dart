import 'package:flutter/material.dart';

class SplashLayout extends StatelessWidget { // Widget que representa la pantalla de carga inicial (Splash Screen)
  const SplashLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold( // Scaffold proporciona la estructura básica visual de la pantalla.
      body: Center( // Centra todo el contenido en el centro de la pantalla
        child: Column( // Columna para apilar el loader y el texto verticalmente.
          mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente la columna dentro del body
          children: [
            CircularProgressIndicator(), // Indicador circular de carga (spinner).
            SizedBox(height: 20), // Espacio vertical entre el spinner y el texto
            Text('Checando...') // Texto informativo mientras se realiza la verificación de sesión
          ],
        ),
      ),
    );
  }
}