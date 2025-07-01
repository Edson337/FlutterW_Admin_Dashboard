import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/models/models.dart';
import 'package:admin_dashboard/providers/providers.dart';
import 'package:admin_dashboard/services/services.dart';
import 'package:admin_dashboard/ui/ui.dart';

class CategoryModal extends StatefulWidget { // Widget modal que se usa para crear o editar una categoría
  final Category? categoria; // Si viene una categoría, es edición. Si es null, es creación.

  const CategoryModal({super.key, this.categoria});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String? id; // Guardará el id de la categoría (si existe, para edición)
  String nombre = ''; // Guardará el nombre de la categoría (nuevo o existente)

  @override
  void initState() {
    super.initState();

    // Si viene categoría, llenamos valores iniciales
    id = widget.categoria?.id;
    nombre = widget.categoria?.nombre ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoriesProvider>(context, listen: false); // Provider para gestionar categorías

    return Container(
      padding: const EdgeInsets.all(20), // Espaciado interior
      height: 500, // Alto fijo del modal
      width: size.width, // Ancho igual al ancho de pantalla
      decoration: buildBoxDecoration(), // Estilo del contenedor
      child: Column(
        children: [
          Row( // -------- Título y botón de cerrar --------
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.categoria?.nombre ?? 'Nueva Categoria', style: CustomLabels.h1.copyWith(color: Colors.white)), // Si viene nombre, muestra el de la categoría, sino dice "Nueva Categoría"
              IconButton(
                icon: const Icon(Icons.close_outlined, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(), // Cierra el modal
              )
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)), // Línea divisoria
          const SizedBox(height: 20),
          TextFormField( // -------- Campo de texto para el nombre de la categoría --------
            initialValue: widget.categoria?.nombre ?? '', // Valor inicial si es edición
            onChanged: (value) => nombre = value, // Actualiza la variable cuando se escribe
            decoration: CustomInputs.loginInputDecoration( // Estilo del input
              hint: 'Nombre de la categoría', 
              label: 'Categoría', 
              icon: Icons.category_outlined
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Container( // -------- Botón para guardar --------
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlinedBtn(
              text: 'Guardar',
              color: Colors.white,
              onPressed: () async {
                try {
                  if (id == null) { // Si no hay id => es una categoría nueva
                    await categoryProvider.newCategory(nombre);
                    NotificationsService.showSnackBarSuccess('Categoría $nombre creada correctamente');
                  } else { // Si hay id => estamos actualizando una existente
                    await categoryProvider.updateCategory(id!, nombre);
                    NotificationsService.showSnackBarSuccess('Categoría $nombre actualizada correctamente');
                  }
                } catch (e) {
                  NotificationsService.showSnackBarError('Error al guardar la categoría');
                }
                Navigator.of(context).pop(); // Cierra el modal después de guardar
              },
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration( // -------- Estilo de fondo y borde del modal --------
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), // Bordes superiores redondeados
    color: Color(0XFF0F2041), // Color de fondo
    boxShadow: [
      BoxShadow(
        color: Colors.black26 // Sombra del contenedor
      ),
    ]
  );
}