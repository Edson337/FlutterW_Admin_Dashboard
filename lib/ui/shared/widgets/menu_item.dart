import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatefulWidget { // Widget de un ítem del menú lateral (sidebar)
  final String text;
  final IconData icon;
  final bool isActive;
  final Function onPressed;

  const MenuItem({super.key, required this.text, required this.icon, this.isActive = false, required this.onPressed});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHovered = false; // Controla si el mouse está encima del ítem (hover)

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250), // Duración de la animación al cambiar color de fondo
      color: isHovered ? Colors.white.withOpacity(0.1) : widget.isActive ? Colors.white.withOpacity(0.1) : Colors.transparent, // Si está en hover, muestra fondo con opacidad. Si está activo, también tiene fondo opaco. Si no está ni hover ni activo, fondo transparente
      child: Material(
        color: Colors.transparent, // Elimina fondo por defecto de Material
        child: InkWell(
          onTap: widget.isActive ? null : () => widget.onPressed(), // Si está activo, desactiva el click (no hace nada). Si no está activo, ejecuta la función al clickear
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Espaciado interno
            child: MouseRegion(
              onEnter: (_) => setState(() => isHovered = true), // Cuando el mouse entra, activa hover
              onExit: (_) => setState(() => isHovered = false), // Cuando el mouse sale, desactiva hover
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // Centra verticalmente el icono y el texto
                children: [
                  Icon(widget.icon, color: Colors.white.withOpacity(0.3)), // Icono del ítem en color blanco con baja opacidad
                  const SizedBox(width: 10),
                  Text(
                    widget.text, 
                    style: GoogleFonts.roboto(fontSize: 16, color: Colors.white.withOpacity(0.8)) // Texto más visible que el icono
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}