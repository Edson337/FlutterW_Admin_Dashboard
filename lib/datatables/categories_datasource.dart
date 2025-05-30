import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/categories_provider.dart';
import '../ui/modals/category_modal.dart';

class CategoriesDTS extends DataTableSource {
  final List<Category> categorias;
  final BuildContext context;

  CategoriesDTS(this.categorias, this.context);

  @override
  DataRow getRow(int index) {
    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);
    final categoria = categorias[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(categoria.id)),
        DataCell(Text(categoria.nombre)),
        DataCell(Text(categoria.usuario.nombre)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (_) => CategoryModal(categoria: categoria)
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7)),
                onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('¿Estas seguro de borrarlo?'),
                    content: Text('Se borrara definitivamente la categoría ${categoria.nombre}'),
                    actions: [
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop()
                      ),
                      TextButton(
                        child: const Text('Borrar'),
                        onPressed: () async {
                          await categoryProvider.deleteCategory(categoria.id);
                          Navigator.of(context).pop();
                        }
                      )
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog);
                },
              ),
            ],
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categorias.length;

  @override
  int get selectedRowCount => 0;
}