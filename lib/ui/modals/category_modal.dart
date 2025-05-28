import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../providers/categories_provider.dart';
import '../../services/notifications_service.dart';
import '../buttons/custom_outlined_btn.dart';
import '../inputs/custom_inputs.dart';
import '../labels/custom_labels.dart';

class CategoryModal extends StatefulWidget {
  final Category? categoria;

  const CategoryModal({super.key, this.categoria});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String? id;
  String nombre = '';

  @override
  void initState() {
    super.initState();

    id = widget.categoria?.id;
    nombre = widget.categoria?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: size.width,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.categoria?.nombre ?? 'Nueva Categoria', style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(
                icon: const Icon(Icons.close_outlined, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: widget.categoria?.nombre ?? '',
            onChanged: (value) => nombre = value,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Nombre de la categoría', 
              label: 'Categoría', 
              icon: Icons.category_outlined
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedBtn(
              text: 'Guardar',
              color: Colors.white,
              onPressed: () async {
                try {
                  if (id == null) {
                    // Crear nueva categoría
                    await categoryProvider.newCategory(nombre);
                    NotificationsService.showSnackBarSuccess('Categoría $nombre creada correctamente');
                  } else {
                    // Actualizar categoría existente
                    await categoryProvider.updateCategory(id!, nombre);
                    NotificationsService.showSnackBarSuccess('Categoría $nombre actualizada correctamente');
                  }
                } catch (e) {
                  NotificationsService.showSnackBarError('Error al guardar la categoría');
                }
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: Color(0XFF0F2041),
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      ),
    ]
  );
}