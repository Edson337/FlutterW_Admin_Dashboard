import 'dart:convert'; // Importa dart:convert para trabajar con JSON

class User { // Modelo que representa un usuario
  String nombre; // Nombre completo del usuario
  String correo; // Correo electrónico del usuario
  String rol; // Rol o tipo de usuario (ejemplo: admin, user)
  bool estado; // Estado activo/inactivo del usuario
  bool google; // Indica si el usuario se registró con Google
  String uid; // Identificador único del usuario
  String? img; // URL de la imagen del usuario (opcional)

  User({required this.nombre, required this.correo, required this.rol, required this.estado, required this.google, required this.uid, this.img});

  factory User.fromJson(String str) => User.fromMap(json.decode(str)); // Factory para crear un User a partir de un String JSON

  String toJson() => json.encode(toMap()); // Convierte la instancia actual a un String JSON

  factory User.fromMap(Map<String, dynamic> json) => User( // Factory para crear una instancia de User a partir de un Map (JSON ya decodificado)
    nombre: json["nombre"],
    correo: json["correo"],
    rol: json["rol"],
    estado: json["estado"],
    google: json["google"],
    uid: json["uid"],
    img: json["img"],
  );

  Map<String, dynamic> toMap() => { // Convierte la instancia actual a un Map para serializar a JSON
    "nombre": nombre,
    "correo": correo,
    "rol": rol,
    "estado": estado,
    "google": google,
    "uid": uid,
    "img": img,
  };
}