import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/datatables/datasources.dart'; // Fuente de datos para la DataTable de categorías
import 'package:admin_dashboard/providers/providers.dart'; // Proveedores globales (Provider)
import 'package:admin_dashboard/ui/ui.dart'; // Estilos, botones y modales personalizados

class CategoriesView extends StatefulWidget { // Vista que muestra la gestión de categorías
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage; // Cantidad de filas por página en la tabla

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getCategories(); // Al inicializar la vista, solicita al provider que cargue las categorías desde el backend
  }

  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<CategoriesProvider>(context).categorias; // Obtiene la lista de categorías desde el provider

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(), // Evita rebote al hacer scroll
        children: [
          Text('Categorías', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable( // Tabla paginada de categorías
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Categoría')),
              DataColumn(label: Text('Creado por')),
              DataColumn(label: Text('Acciones')),
            ], 
            source: CategoriesDTS(categorias, context), // Fuente de datos personalizada para poblar la tabla
            header: const Text('Categorías Disponibles', maxLines: 2), // Encabezado de la tabla
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10; // Actualiza el número de filas por página
              });
            },
            rowsPerPage: _rowsPerPage, // Número actual de filas por página
            actions: [ // Botón de acción superior derecha (crear nueva categoría)
              CustomIconBtn(
                text: 'Crear',
                icon: Icons.add_outlined,
                onPressed: () {
                  showModalBottomSheet( // Abre el modal para crear una nueva categoría
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (_) => const CategoryModal(categoria: null) // Modal de categoría sin datos (modo creación)
                  );
                }, 
              )
            ],
          )
        ],
      ),
    );
  }
}