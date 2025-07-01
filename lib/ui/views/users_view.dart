import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/datatables/datasources.dart'; // DataSource para la tabla de usuarios
import 'package:admin_dashboard/providers/providers.dart'; // Proveedores de estado
import 'package:admin_dashboard/ui/ui.dart'; // Componentes UI personalizados

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider que maneja la lista de usuarios y su estado
    final usersProvider = Provider.of<UsersProvider>(context);
    // DataSource personalizado para la tabla paginada de usuarios
    final usersDataSourse = UsersDTS(usersProvider.users);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(), // Evita el efecto de rebote en el scroll
        children: [
          // TÍTULO DE LA VISTA DE USUARIOS
          Text('Users', style: CustomLabels.h1),
          const SizedBox(height: 10),
          // TABLA PAGINADA CON FUNCIONALIDAD DE ORDENAMIENTO
          PaginatedDataTable(
            sortAscending: usersProvider.ascending, // Estado del ordenamiento ascendente/descendente
            sortColumnIndex: usersProvider.sortColumnIndex, // Índice de la columna actualmente ordenada
            columns: [
              // COLUMNA DE AVATAR (sin ordenamiento)
              const DataColumn(label: Text('Avatar')),
              // COLUMNA DE NOMBRE (con ordenamiento)
              DataColumn(label: const Text('Nombre'), onSort: (colIndex, _) {
                usersProvider.sortColumnIndex = colIndex; // Actualiza el índice de columna ordenada
                usersProvider.sort<String>((user) => user.nombre); // Ordena por nombre
              }),
              // COLUMNA DE EMAIL (con ordenamiento)
              DataColumn(label: const Text('Email'), onSort: (colIndex, _) {
                usersProvider.sortColumnIndex = colIndex; // Actualiza el índice de columna ordenada
                usersProvider.sort<String>((user) => user.correo); // Ordena por correo
              }),
              // COLUMNA DE UID (sin ordenamiento)
              const DataColumn(label: Text('UID')),
              // COLUMNA DE ACCIONES (sin ordenamiento)
              const DataColumn(label: Text('Acciones')),
            ],
            source: usersDataSourse, // Fuente de datos para la tabla
            onPageChanged: (page) {}, // Callback para cambio de página (actualmente vacío)
          )
        ],
      ),
    );
  }
}