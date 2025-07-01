import 'package:flutter/material.dart'; // Importación de la librería de Flutter para crear interfaces de usuario

import 'package:admin_dashboard/models/models.dart'; // Importación del modelo User (modelo de datos de usuarios)
import 'package:admin_dashboard/services/services.dart'; // Importación del NavigationService (navegación global sin contexto)

class UsersDTS extends DataTableSource { // Clase que extiende DataTableSource para alimentar una PaginatedDataTable con usuarios
  final List<User> users; // Lista de usuarios que se mostrarán en la tabla

  UsersDTS(this.users);

  @override
  DataRow getRow(int index) {
    final user = users[index]; // Obtiene el usuario correspondiente al índice actual
    final image = (user.img == null) // Selección de la imagen del usuario:
    ? const Image(image: AssetImage('no-image.jpg'), width: 35, height: 35) // Si no tiene imagen, se muestra una imagen por defecto ('no-image.jpg')
    : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!, width: 35, height: 35); // Si tiene imagen, se muestra con efecto de fade-in mientras carga
    
    return DataRow.byIndex( // Retorna una fila (DataRow) para la DataTable
      index: index,
      cells: [
        DataCell(ClipOval(child: image)), // Primera columna: Imagen del usuario (en forma circular)
        DataCell(Text(user.nombre)), // Segunda columna: Nombre del usuario
        DataCell(Text(user.correo)), // Tercera columna: Correo electrónico del usuario
        DataCell(Text(user.uid)), // Cuarta columna: UID (identificador único del usuario)
        DataCell( // Quinta columna: Botón de edición
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => NavigationService.replaceTo('/dashboard/users/${user.uid}'), // Navega a la pantalla de edición de usuario usando el NavigationService
          ),
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false; // Indica que el número de filas es exacto y conocido

  @override
  int get rowCount => users.length; // Número total de usuarios (filas en la tabla)

  @override
  int get selectedRowCount => 0; // Número de filas seleccionadas (sin selección múltiple aquí)
}