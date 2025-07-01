import 'package:flutter/material.dart';

class NavbarAvatar extends StatelessWidget { // Widget que representa el avatar del usuario en la barra de navegación (Navbar)
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval( // ClipOval recorta el contenido en forma de círculo (avatar redondo)
      child: Container(
        width: 30, // Ancho del avatar
        height: 30, // Alto del avatar
        child: Image.asset('Usuario.png'), // Imagen del avatar cargada desde assets
      ),
    );
  }
}