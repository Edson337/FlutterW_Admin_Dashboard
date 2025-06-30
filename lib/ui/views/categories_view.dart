import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/datatables/datasources.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/ui/ui.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<CategoriesProvider>(context).categorias;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Categorías', style: CustomLabels.h1),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Categoría')),
              DataColumn(label: Text('Creado por')),
              DataColumn(label: Text('Acciones')),
            ], 
            source: CategoriesDTS(categorias, context),
            header: const Text('Categorías Disponibles', maxLines: 2),
            onRowsPerPageChanged: (value) {
              setState(() {
                _rowsPerPage = value ?? 10;
              });
            },
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconBtn(
                text: 'Crear',
                icon: Icons.add_outlined,
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (_) => const CategoryModal(categoria: null)
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