import 'package:flutter/material.dart'; // Importa el paquete de Flutter necesario para widgets y UI

class CustomIconBtn extends StatelessWidget { // Widget personalizado para crear un botón con ícono y texto
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  final IconData icon;
  const CustomIconBtn({super.key, required this.onPressed, required this.text, this.color = Colors.indigo, this.isFilled = false, required this.icon});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle( // Define el estilo visual del botón
        shape: WidgetStateProperty.all(const StadiumBorder()), // Le da forma redondeada estilo píldora
        backgroundColor: WidgetStateProperty.all(color.withOpacity(0.5)), // Color de fondo con opacidad
        overlayColor: WidgetStateProperty.all(color.withOpacity(0.3)), // Color al presionar (efecto de toque)
      ),
      onPressed: () => onPressed(), // Acción al presionar el botón
      child: Row( // Contenido del botón: un ícono y un texto en fila
        children: [
          Icon(icon, color: Colors.white), // Ícono en blanco
          Text(text, style: const TextStyle(color: Colors.white)) // Texto en blanco
        ],
      )
    );
  }
}