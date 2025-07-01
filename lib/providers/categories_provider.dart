import 'package:flutter/material.dart'; // Importación del paquete Flutter necesario para ChangeNotifier y notificaciones a la UI

import 'package:admin_dashboard/api/CafeApi.dart'; // Importación de la clase que maneja las peticiones HTTP
import 'package:admin_dashboard/models/models.dart'; // Importación del modelo Category y CategoriesResponse

class CategoriesProvider extends ChangeNotifier { // Provider encargado de la gestión del estado de las categorías
  List<Category> categorias = []; // Lista de categorías actual cargada en memoria

  getCategories() async { // Método para obtener todas las categorías desde el backend
    try {
      final response = await CafeApi.httpGet('/categorias'); // Realiza la petición GET al backend (endpoint /categorias)
      final categoriesResponse = CategoriesResponse.fromMap(response); // Parsea la respuesta a un objeto CategoriesResponse
      categorias = [...categoriesResponse.categorias]; // Actualiza la lista de categorías locales con las que vienen de la API
      notifyListeners(); // Notifica a los widgets que estén escuchando
    } catch (e) {
      throw('Error al cargar las categorias: $e'); // Si ocurre un error, lanza una excepción personalizada
    }
  }

  Future newCategory(String name) async { // Método para crear una nueva categoría
    final data = {'nombre': name}; // Datos a enviar en el cuerpo del POST
    try {
      final json = await CafeApi.httpPost('/categorias', data); // Llama al endpoint POST para crear la categoría
      final newCategory = Category.fromMap(json); // Parsea la respuesta a un objeto Category
      categorias.add(newCategory); // Añade la nueva categoría a la lista local
      notifyListeners(); // Notifica a la UI
    } catch (e) {
      throw('Error al crear la categoria: $e');
    }
  }

  Future updateCategory(String id, String name) async { // Método para actualizar el nombre de una categoría
    final data = {'nombre': name}; // Datos a enviar
    try {
      await CafeApi.httpPut('/categorias/$id', data); // Llama al endpoint PUT para actualizar la categoría
      categorias = categorias.map( // Actualiza localmente la lista de categorías
        (category) {
          if (category.id != id) return category; // Si no es la que queremos, la dejamos igual
          category.nombre = name; // Si es la que queremos, le cambiamos el nombre
          return category;
        }
      ).toList();
      notifyListeners(); // Notifica a la UI
    } catch (e) {
      throw('Error al actualizar la categoria: $e');
    }
  }

  Future deleteCategory(String id) async { // Método para eliminar una categoría
    try {
      await CafeApi.httpDelete('/categorias/$id', {}); // Llama al endpoint DELETE
      categorias.removeWhere((category) => category.id == id); // Elimina localmente la categoría de la lista
      notifyListeners(); // Notifica a la UI para que se actualice
    } catch (e) {
      throw('Error al eliminar la categoria: $e');
    }
  }
}