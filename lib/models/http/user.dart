import 'dart:convert';

class User {
  String nombre;
  String correo;
  String rol;
  bool estado;
  bool google;
  String uid;
  String? img;

  User({required this.nombre, required this.correo, required this.rol, required this.estado, required this.google, required this.uid, this.img});

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    nombre: json["nombre"],
    correo: json["correo"],
    rol: json["rol"],
    estado: json["estado"],
    google: json["google"],
    uid: json["uid"],
    img: json["img"],
  );

  Map<String, dynamic> toMap() => {
    "nombre": nombre,
    "correo": correo,
    "rol": rol,
    "estado": estado,
    "google": google,
    "uid": uid,
    "img": img,
  };
}