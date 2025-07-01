import 'package:flutter/material.dart'; // Importa Flutter Material para construir la UI
import 'package:provider/provider.dart'; // Importa Provider para manejar el estado global

import 'package:admin_dashboard/router/router.dart'; // Rutas de navegación definidas
import 'package:admin_dashboard/providers/providers.dart'; // Proveedores (Auth, SideMenu, etc)
import 'package:admin_dashboard/services/services.dart'; // Servicios como navegación o notificaciones
import 'package:admin_dashboard/ui/ui.dart'; // Widgets UI reutilizables como Logo, MenuItem, etc.

class Sidebar extends StatelessWidget { // Widget del menú lateral (Sidebar)
  const Sidebar({super.key});

  void navigateTo(String routeName) { // Método para navegar a una nueva ruta y cerrar el SideMenu
    NavigationService.replaceTo(routeName); // Cambia de ruta (pushReplacementNamed)
    SideMenuProvider.closeMenu(); // Cierra el SideMenu (solo afecta en móviles o pantallas pequeñas)
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context); // Obtiene el Provider del SideMenu para saber qué página está activa

    return Container(
      width: 200, // Ancho fijo del sidebar
      height: double.infinity, // Altura completa de pantalla
      decoration: buildBoxDecoration(), // Fondo degradado y sombra
      child: ListView( // Lista de menú desplazable (scrollable)
        physics: const ClampingScrollPhysics(), // Scroll tipo "clamp" (sin rebote)
        children: [
          const Logo(), // Muestra el logo en la parte superior
          const SizedBox(height: 50),
          const TextSeparator(text: 'Main'), // Título separador de sección
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.dashboardRoute, // Marca como activo si está en esta ruta
            text: 'Dashboard',
            icon: Icons.compass_calibration_outlined,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute) // Navega a Dashboard
          ),
          MenuItem(text: 'Orders', icon: Icons.shopping_cart_outlined, onPressed: () {}),
          MenuItem(text: 'Analytics', icon: Icons.show_chart_outlined, onPressed: () {}),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
            text: 'Categories', 
            icon: Icons.layers_outlined, 
            onPressed: () => navigateTo(Flurorouter.categoriesRoute)
          ),
          MenuItem(text: 'Products', icon: Icons.dashboard_outlined, onPressed: () {}),
          MenuItem(text: 'Discount', icon: Icons.attach_money_outlined, onPressed: () {}),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
            text: 'Users', 
            icon: Icons.people_alt_outlined, 
            onPressed: () => navigateTo(Flurorouter.usersRoute)
          ),
          const SizedBox(height: 30),
          const TextSeparator(text: 'UI Elements'), // Separador de otra sección
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
            text: 'Icons',
            icon: Icons.list_alt_outlined,
            onPressed: () => navigateTo(Flurorouter.iconsRoute)
          ),
          MenuItem(text: 'Marketing', icon: Icons.mark_email_read_outlined, onPressed: () {}),
          MenuItem(text: 'Campaign', icon: Icons.note_add_outlined, onPressed: () {}),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
            text: 'Blank Page',
            icon: Icons.post_add_outlined,
            onPressed: () => navigateTo(Flurorouter.blankRoute)
          ),
          const SizedBox(height: 50),
          const TextSeparator(text: 'Exit'), // Separador de sección de salida
          MenuItem(
            text: 'Logout',
            icon: Icons.exit_to_app_outlined,
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout() // Llama al método logout del AuthProvider
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration( // Decoración del contenedor Sidebar
    gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092042)]), // Fondo en dos tonos de azul oscuro (gradiente)
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]
  );
}