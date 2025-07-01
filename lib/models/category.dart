import 'dart:convert'; // Importa dart:convert para trabajar con JSON

class Category { // Clase que representa una categoría
  String id; // Identificador único de la categoría
  String nombre; // Nombre de la categoría
  _Usuario usuario; // Usuario que creó o está asociado a esta categoría (clase interna _Usuario)

  Category({required this.id, required this.nombre, required this.usuario});

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str)); // Factory para crear una instancia de Category desde un JSON string

  String toJson() => json.encode(toMap()); // Convierte la instancia actual a un JSON string

  factory Category.fromMap(Map<String, dynamic> json) => Category( // Factory para crear una instancia de Category desde un Map
    id: json["_id"],
    nombre: json["nombre"],
    usuario: _Usuario.fromMap(json["usuario"]),
  );

  Map<String, dynamic> toMap() => { // Convierte la instancia a Map para serializarla a JSON
    "_id": id,
    "nombre": nombre,
    "usuario": usuario.toJson(),
  };

  @override // Override para facilitar impresión y debugging
  String toString() {
    return 'Categoria: $nombre}';
  }
}

class _Usuario { // Clase interna que representa al usuario asociado a la categoría
  String id; // ID único del usuario
  String nombre; // Nombre del usuario

  _Usuario({required this.id, required this.nombre});

  factory _Usuario.fromJson(String str) => _Usuario.fromMap(json.decode(str)); // Factory para crear instancia desde JSON string

  String toJson() => json.encode(toMap()); // Convierte la instancia a JSON string

  factory _Usuario.fromMap(Map<String, dynamic> json) => _Usuario( // Factory para crear la instancia desde Map
    id: json["_id"],
    nombre: json["nombre"],
  );

  Map<String, dynamic> toMap() => { // Convierte la instancia a Map para serializar
    "_id": id,
    "nombre": nombre,
  };
}