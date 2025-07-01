import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSeparator extends StatelessWidget { // Widget Stateless para mostrar un separador de texto (normalmente usado en menús o listas)
  final String text; // Texto que se va a mostrar como separador
  const TextSeparator({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Padding horizontal a ambos lados del texto
      margin: const EdgeInsets.only(bottom: 5), // Margen inferior de 5px para separar de otros widgets
      child: Text(
        text, // Texto recibido por el widget
        style: GoogleFonts.roboto( // Aplica la fuente Roboto usando Google Fonts
          color: Colors.white.withOpacity(0.3), // Color blanco con 30% de opacidad (gris claro)
          fontSize: 12
        ),
      ),
    );
  }
}