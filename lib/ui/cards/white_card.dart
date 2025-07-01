import 'package:flutter/material.dart'; // Importa los paquetes necesarios de Flutter y Google Fonts
import 'package:google_fonts/google_fonts.dart';

class WhiteCard extends StatelessWidget { // Widget reutilizable que representa una tarjeta blanca (estilo material) para contener otros widgets
  final String? title;
  final Widget child;
  final double? width;

  const WhiteCard({super.key, this.title, required this.child, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Si se recibe un ancho, lo aplica
      margin: const EdgeInsets.all(8), // Margen exterior de la tarjeta
      padding: const EdgeInsets.all(10), // Relleno interior (padding)
      decoration: buildBoxDecoration(), // Aplicación del estilo de caja (fondo blanco, borde redondeado, sombra)
      child: Column( // Contenido interno de la tarjeta
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea todo a la izquierda (inicio)
        children: [
          if (title != null) ...[ // Si el título existe, lo muestra en la parte superior con un Divider
            FittedBox(
              fit: BoxFit.contain, // Ajusta el texto para que no desborde
              child: Text(
                title!,
                style: GoogleFonts.roboto( // Estilo de texto usando Google Fonts (Roboto)
                  fontSize: 15, fontWeight: FontWeight.bold
                )
              ),
            ),
            const Divider() // Línea divisoria debajo del título
          ],
          child // Aquí va el contenido que reciba esta tarjeta
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration( // Método privado que construye el estilo de la caja
    color: Colors.white, // Fondo blanco
    borderRadius: BorderRadius.circular(5), // Bordes redondeados (radio 5)
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)] // Sombra sutil (negro muy transparente) y difuminado de la sombra
  );
}