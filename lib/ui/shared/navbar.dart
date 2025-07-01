import 'package:flutter/material.dart';

import 'package:admin_dashboard/providers/providers.dart'; // Importa los Providers (en este caso el SideMenuProvider)
import 'package:admin_dashboard/ui/ui.dart'; // Importa widgets UI reutilizables (SearchText, NotificationsIndicator, NavbarAvatar, etc.)

class Navbar extends StatelessWidget { // Widget Navbar (barra superior del dashboard)
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de pantalla para responsive design

    return Container(
      width: double.infinity, // Ocupa todo el ancho disponible
      height: 50,
      decoration: buildBoxDecoration(), // Aplica la decoración de fondo y sombra
      child: Row(
        children: [
          if (size.width <= 700) IconButton(icon: const Icon(Icons.menu_outlined), onPressed: () => SideMenuProvider.openMenu()), // Si el ancho de pantalla es menor o igual a 700, muestra el icono del menú hamburguesa
          const SizedBox(width: 10),
          if (size.width >= 390) ConstrainedBox(constraints: const BoxConstraints(maxWidth: 250), child: const SearchText()), // Si el ancho de pantalla es mayor o igual a 390, muestra el campo de búsqueda
          const Spacer(), // Espaciador flexible para empujar los siguientes widgets al extremo derecho
          const NotificationsIndicator(), // Widget que muestra el icono de notificaciones
          const SizedBox(width: 10), // Espaciado
          const NavbarAvatar(), // Widget para el avatar del usuario
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration( // Método que construye la decoración de fondo del Navbar
    color: Colors.white,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]
  );
}