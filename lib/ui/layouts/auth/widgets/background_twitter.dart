import 'package:flutter/material.dart';

class BackgroundTwitter extends StatelessWidget { // Widget que muestra un fondo con imagen estilo Twitter y su logo centrado
  const BackgroundTwitter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(), // Aplica la decoración del fondo con imagen
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400), // Limita el ancho máximo del contenido a 400 píxeles
        child: const Center( // Centra el contenido hijo (el logo)
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30), // Añade espacio horizontal alrededor del logo
            child: Image( // Imagen del logo de Twitter en color blanco
              image: AssetImage('twitter-white-logo.png'),
              width: 400, // Ancho fijo del logo
            ),
          )
        )
      )
    );
  }

  BoxDecoration buildBoxDecoration() { // Método que retorna una BoxDecoration con imagen de fondo
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('twitter-bg.png'), // Imagen de fondo
        fit: BoxFit.cover // La imagen cubre todo el contenedor sin distorsión
      )
    );
  }
}