import 'package:flutter/material.dart';

import 'package:admin_dashboard/ui/ui.dart'; // Importa estilos de input personalizados desde tu carpeta de UI

class SearchText extends StatelessWidget { // Widget para un campo de búsqueda reutilizable
  const SearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40, // Altura fija para el campo de búsqueda
      decoration: buildBoxDecoration(), // Llama al método que devuelve la decoración del contenedor
      child: TextField(
        decoration: CustomInputs.searchInputDecoration(hint: 'Buscar', icon: Icons.search_rounded), // Campo de texto para buscar
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration( // Método para crear la decoración del contenedor (fondo gris claro con bordes redondeados)
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.1)
  );
}