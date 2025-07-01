import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitle extends StatelessWidget { // Widget para mostrar el título principal de la pantalla, con logo y texto grande
  const CustomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Padding horizontal alrededor de todo el contenido
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea todo a la izquierda
        children: [
          Image.asset( // Imagen del logo de Twitter en blanco
            'twitter-white-logo.png',
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 20), // Espaciado vertical debajo del logo
          FittedBox(
            fit: BoxFit.contain, // Hace que el texto no desborde el contenedor
            child: Text(
              'Happening Now',
              style: GoogleFonts.montserratAlternates(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            ),
          )
        ]
      )
    );
  }
}