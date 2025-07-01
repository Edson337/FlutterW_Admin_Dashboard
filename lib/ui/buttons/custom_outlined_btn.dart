import 'package:flutter/material.dart'; // Importa el paquete de Flutter necesario para widgets y estilos

class CustomOutlinedBtn extends StatelessWidget { // Widget personalizado para crear un botón de borde (OutlinedButton) con más opciones de personalización
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final bool isTextWhite;

  const CustomOutlinedBtn({super.key, required this.onPressed, required this.text, this.color = Colors.blue, this.isFilled = false, this.isTextWhite = false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle( // Define el estilo visual del botón
        shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), // Forma con bordes redondeados (radio 30)
        side: WidgetStateProperty.all(BorderSide(color: color)), // Color del borde del botón
        backgroundColor: WidgetStateProperty.all(isFilled ? color.withOpacity(0.3) : Colors.transparent) // Color de fondo (si isFilled es true, aplica un fondo semitransparente)
      ),
      onPressed: () => onPressed(), // Acción al presionar el botón
      child: Padding( // Contenido interno del botón: el texto con padding
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(text, style: TextStyle(fontSize: 16, color: isTextWhite ? Colors.white : color)), // Color del texto según el flag
      )
    );
  }
}