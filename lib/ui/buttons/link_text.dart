import 'package:flutter/material.dart'; // Importa el paquete de Flutter necesario para widgets

class LinkText extends StatefulWidget { // Widget personalizado tipo "Link", que reacciona al pasar el mouse y al hacer clic
  final String text;
  final Function? onPressed;

  const LinkText({super.key, required this.text, this.onPressed});

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> { // Estado asociado al widget LinkText
  bool isHover = false; // Variable para controlar si el mouse está encima del texto (hover)
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ // Acción al hacer clic
        if(widget.onPressed != null) widget.onPressed!(); // Si la función existe, la ejecuta
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Cambia el cursor a forma de mano (indica que es clickeable)
        onEnter: (_) => setState(() => isHover = true), // Al entrar el mouse: activa el estado hover
        onExit: (_) => setState(() => isHover = false), // Al salir el mouse: desactiva el estado hover
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Margen alrededor del texto
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              color: isHover ? Colors.grey : Colors.grey[700], // Cambia el color cuando hay hover
            ),
          ),
        ),
      ),
    );
  }
}