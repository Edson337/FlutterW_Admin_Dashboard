import 'dart:convert'; // Importa dart:convert para convertir entre JSON y objetos Dart

import 'package:admin_dashboard/models/models.dart'; // Importa el modelo Category para mapear los datos de categorías

class CategoriesResponse { // Clase que representa la respuesta del backend con una lista de categorías
    int total; // Número total de categorías (por ejemplo, para paginación)
    List<Category> categorias; // Lista de objetos Category

    CategoriesResponse({required this.total, required this.categorias}); // Factory para crear una instancia a partir de un JSON string

    factory CategoriesResponse.fromJson(String str) => CategoriesResponse.fromMap(json.decode(str)); // Convierte la instancia a un JSON string

    String toJson() => json.encode(toMap());

    factory CategoriesResponse.fromMap(Map<String, dynamic> json) => CategoriesResponse( // Factory para crear la instancia a partir de un Map<String, dynamic>
      total: json["total"], // Lee el total de categorías del JSON
      categorias: List<Category>.from(json["categorias"].map((x) => Category.fromMap(x))), // Convierte la lista JSON de categorías en una lista de objetos Category
    );

    Map<String, dynamic> toMap() => { // Convierte la instancia actual a un Map<String, dynamic> para serializar
      "total": total, // Número total de categorías
      "categorias": List<dynamic>.from(categorias.map((x) => x.toMap())), // Convierte cada objeto Category en Map para serialización JSON
    };
}