import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/ui.dart'; // Importa otros widgets de la carpeta ui, como el LinkText

class LinksBar extends StatelessWidget { // Widget para mostrar una barra de enlaces en la parte inferior (tipo footer)
  const LinksBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla

    return Container(
      color: Colors.black, // Fondo negro para la barra
      height: (size.width > 1000) ? size.height * 0.05 : null, // Si la pantalla es ancha (>1000px), le asigna un alto proporcional al 5% del alto total. Si no, el alto será automático según el contenido
      child: const Wrap( // El contenido es un Wrap, permite que los enlaces se acomoden en varias filas si no caben en una sola
        alignment: WrapAlignment.center, // Centra los enlaces horizontalmente
        children: [ // Cada LinkText representa un texto de enlace (simula links típicos de un footer de web)
          LinkText(text: 'About'),
          LinkText(text: 'Help Center'),
          LinkText(text: 'Terms of Service'),
          LinkText(text: 'Privacy Policy'),
          LinkText(text: 'Cookie Policy'),
          LinkText(text: 'Ads Info'),
          LinkText(text: 'Blog'),
          LinkText(text: 'Status'),
          LinkText(text: 'Careers'),
          LinkText(text: 'Brand Resource'),
          LinkText(text: 'Advertising'),
          LinkText(text: 'Marketing'),
        ],
      ),
    );
  }
}