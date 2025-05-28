import 'package:flutter/material.dart';

import '../api/CafeApi.dart';
import '../models/category.dart';
import '../models/http/categories_response.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> categorias = [];

  getCategories() async {
    try {
      final response = await CafeApi.httpGet('/categorias');
      final categoriesResponse = CategoriesResponse.fromMap(response);
      categorias = [...categoriesResponse.categorias];
      notifyListeners();
      print('Categorias: $categorias');
    } catch (e) {
      throw('Error al cargar las categorias: $e');
    }
  }

  Future newCategory(String name) async {
    final data = {'nombre': name};
    try {
      final json = await CafeApi.httpPost('/categorias', data);
      final newCategory = Category.fromMap(json);
      categorias.add(newCategory);
      notifyListeners();
      print('Categoria creada: ${newCategory.nombre}');
    } catch (e) {
      throw('Error al crear la categoria: $e');
    }
  }

  Future updateCategory(String id, String name) async {
    final data = {'nombre': name};
    try {
      await CafeApi.httpPut('/categorias/$id', data);
      categorias = categorias.map(
        (category) {
          if (category.id != id) return category;
          category.nombre = name;
          return category;
        }
      ).toList();
      notifyListeners();
      print('Categoria actualizada: $name');
    } catch (e) {
      throw('Error al actualizar la categoria: $e');
    }
  }

  Future deleteCategory(String id) async {
    try {
      await CafeApi.httpDelete('/categorias/$id', {});
      categorias.removeWhere((category) => category.id == id);
      print('Categoria eliminada: $id');
      notifyListeners();
    } catch (e) {
      throw('Error al eliminar la categoria: $e');
    }
  }
}