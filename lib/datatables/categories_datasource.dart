// Importación de librerías necesarias
import 'package:flutter/material.dart'; // Para crear la interfaz de usuario
import 'package:provider/provider.dart'; // Para acceder a los Providers de estado

// Importación de modelos, providers y UI específicos del proyecto
import 'package:admin_dashboard/models/models.dart'; // Acceso al modelo Category
import 'package:admin_dashboard/providers/providers.dart'; // Acceso al CategoriesProvider
import 'package:admin_dashboard/ui/ui.dart'; // Acceso al CategoryModal

class CategoriesDTS extends DataTableSource { // Clase que extiende DataTableSource: permite alimentar datos a un PaginatedDataTable
  final List<Category> categorias; // Lista de categorías que se mostrarán en la tabla
  final BuildContext context; // Contexto necesario para acceder a Providers y navegación

  CategoriesDTS(this.categorias, this.context);

  @override
  DataRow getRow(int index) {
    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false); // Obtiene el CategoriesProvider sin escuchar cambios (listen: false)
    final categoria = categorias[index]; // Obtiene la categoría actual según el índice recibido

    return DataRow.byIndex( // Retorna una fila de la DataTable (DataRow)
      index: index,
      cells: [
        DataCell(Text(categoria.id)), // Primera columna: ID de la categoría
        DataCell(Text(categoria.nombre)), // Segunda columna: Nombre de la categoría
        DataCell(Text(categoria.usuario.nombre)), // Tercera columna: Nombre del usuario que creó la categoría
        DataCell( // Cuarta columna: Acciones (Editar y Eliminar)
          Row(
            children: [
              IconButton( // Botón para Editar la categoría
                icon: const Icon(Icons.edit_outlined),
                onPressed: () { // Al presionar, abre un modal inferior para editar la categoría
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (_) => CategoryModal(categoria: categoria) // Muestra el formulario de edición
                  );
                },
              ),
              IconButton( // Botón para Eliminar la categoría
                icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7)),
                onPressed: () { // Al presionar, muestra un cuadro de confirmación
                  final dialog = AlertDialog(
                    title: const Text('¿Estas seguro de borrarlo?'),
                    content: Text('Se borrara definitivamente la categoría ${categoria.nombre}'),
                    actions: [
                      TextButton( // Botón para cancelar la acción
                        child: const Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop() // Cierra el diálogo
                      ),
                      TextButton( // Botón para confirmar el borrado
                        child: const Text('Borrar'),
                        onPressed: () async { // Llama al método deleteCategory del Provider
                          await categoryProvider.deleteCategory(categoria.id);
                          Navigator.of(context).pop(); // Cierra el diálogo después de borrar
                        }
                      )
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog); // Muestra el diálogo de confirmación
                },
              ),
            ],
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false; // Indica que se conoce exactamente el número de filas

  @override
  int get rowCount => categorias.length; // Número total de filas (según la cantidad de categorías)

  @override
  int get selectedRowCount => 0; // Número de filas seleccionadas (sin selección múltiple en este caso)
}