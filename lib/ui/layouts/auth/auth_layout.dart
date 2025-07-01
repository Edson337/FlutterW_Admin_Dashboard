import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/ui.dart'; // Importa widgets reutilizables como LinksBar, BackgroundTwitter, CustomTitle, etc.

class AuthLayout extends StatelessWidget { // Layout general para pantallas de Login y Registro
  final Widget child; // Este es el contenido específico de cada página (LoginView o RegisterView)
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Tamaño de la pantalla (para responsive)
    return Scaffold(
      body: Scrollbar( // Agrega scroll visual
        child: ListView(
          physics: const ClampingScrollPhysics(), // Tipo de scroll (sin rebote)
          children: [ // Si el ancho de pantalla es mayor a 1000px => Layout de escritorio, sino => Layout móvil
            (size.width > 1000) ? _DesktopBody(child: child) : _MobileBody(child: child),
            const LinksBar() // Barra de links al final (footer)
          ]
        ),
      )
    );
  }
}

class _DesktopBody extends StatelessWidget { // ==================== Layout para Escritorio ====================
  final Widget child;
  const _DesktopBody({required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Ocupa el 95% del alto de pantalla
    return Container(
      width: size.width,
      height: size.height * 0.95,
      child: Row(
        children: [ // Parte izquierda: Imagen de fondo estilo Twitter
          const Expanded(child: BackgroundTwitter()),
          Container( // Parte derecha: Contenedor negro con el título y el formulario
            width: 600, // Ancho fijo del panel de login/register
            height: double.infinity, // Ocupa toda la altura disponible
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 20), // Espaciado superior
                const CustomTitle(), // Logo y Título principal
                const SizedBox(height: 50), // Más espacio
                Expanded(child: child) // Aquí se renderiza el LoginView o RegisterView
              ]
            )
          )
        ]
      )
    );
  }
}

class _MobileBody extends StatelessWidget { // ==================== Layout para Móvil ====================
  final Widget child;
  const _MobileBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Alinea el contenido arriba
        children: [
          const SizedBox(height: 20),
          const CustomTitle(), // Logo y título arriba
          Container( // Contenedor para el formulario (login o register)
            width: double.infinity,
            height: 420, // Alto fijo
            child: child,
          ),
          Container( // Imagen de fondo estilo Twitter (solo visible en móvil debajo del formulario)
            width: double.infinity,
            height: 400,
            child: const BackgroundTwitter(),
          )
        ],
      ),
    );
  }
}