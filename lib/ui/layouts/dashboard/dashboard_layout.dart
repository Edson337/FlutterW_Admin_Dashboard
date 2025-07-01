import 'package:flutter/material.dart';

import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/ui/ui.dart';

class DashboardLayout extends StatefulWidget { // Layout base del Dashboard (para todas las páginas internas después del login)
  final Widget child; // Este es el contenido específico de cada pantalla dentro del dashboard (UsersView, CategoriesView, etc.)

  const DashboardLayout({super.key, required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Inicializa el AnimationController global del SideMenuProvider (para controlar la animación de apertura/cierre del menú lateral)
    SideMenuProvider.menuController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de pantalla (ancho / alto)

    return Scaffold(
      backgroundColor: const Color(0xffEDF1F2), // Color de fondo general
      body: Stack( // Permite apilar widgets
        children: [
          Row( // ======================= Desktop Layout =======================
            children: [
              if (size.width >= 700) const Sidebar(), // Si la pantalla es ancha (>=700px), muestra el Sidebar fijo
              Expanded( // Contenido principal: Navbar arriba y el contenido de cada vista debajo
                child: Column(
                  children: [
                    const Navbar(), // Barra superior de navegación
                    Expanded(
                      child: Container(
                        child: widget.child, // El contenido específico de cada página
                      )
                    )
                  ],
                ),
              )
            ],
          ),
          if (size.width < 700) AnimatedBuilder( // ======================= Mobile Sidebar Animado =======================
            animation: SideMenuProvider.menuController, // Se reconstruye cuando avanza la animación
            builder: (context, _) => Stack(
              children: [
                if (SideMenuProvider.isOpen) Opacity( // Fondo oscurecido cuando el sidebar está abierto
                  opacity: SideMenuProvider.opacity.value, // Opacidad animada
                  child: GestureDetector(
                    onTap: () => SideMenuProvider.closeMenu(), // Al tocar fuera, cierra el menú
                    child: Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.black26,
                    ),
                  ),
                ),
                Transform.translate( // Sidebar deslizable
                  offset: Offset(SideMenuProvider.movement.value, 0), // Anima el desplazamiento horizontal
                  child: const Sidebar(), // Menú lateral
                )
              ],
            )
          ),
        ],
      )
    );
  }
}