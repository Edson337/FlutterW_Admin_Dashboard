import 'dart:convert';

class Category {
  String id;
  String nombre;
  _Usuario usuario;

  Category({
      required this.id,
      required this.nombre,
      required this.usuario,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
      id: json["_id"],
      nombre: json["nombre"],
      usuario: _Usuario.fromMap(json["usuario"]),
  );

  Map<String, dynamic> toMap() => {
      "_id": id,
      "nombre": nombre,
      "usuario": usuario.toJson(),
  };

  @override
  String toString() {
    return 'Categoria: $nombre}';
  }
}

class _Usuario {
  String id;
  String nombre;

  _Usuario({
      required this.id,
      required this.nombre,
  });

  factory _Usuario.fromJson(String str) => _Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory _Usuario.fromMap(Map<String, dynamic> json) => _Usuario(
      id: json["_id"],
      nombre: json["nombre"],
  );

  Map<String, dynamic> toMap() => {
      "_id": id,
      "nombre": nombre,
  };
}