import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget { // Widget que representa el logo que aparece en la app
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30), // Espacio superior
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido horizontalmente
        children: [ // -------- Icono del logo --------
          const Icon(Icons.bubble_chart_outlined, color: Color(0xff7A6BF5)),
          const SizedBox(width: 10),
          Text( // -------- Texto del logo --------
            'Admin', 
            style: GoogleFonts.montserratAlternates( // Estilo usando Google Fonts
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color: Colors.white
            )
          )
        ],
      ),
    );
  }
}