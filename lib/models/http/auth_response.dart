import 'dart:convert';

class AuthResponse {
  Usuario usuario;
  String token;

  AuthResponse({required this.usuario, required this.token});

  factory AuthResponse.fromJson(String str) => AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
    usuario: Usuario.fromMap(json["usuario"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "usuario": usuario.toJson(),
    "token": token,
  };
}

class Usuario {
  String nombre;
  String correo;
  String rol;
  bool estado;
  bool google;
  String uid;

  Usuario({required this.nombre, required this.correo, required this.rol, required this.estado, required this.google, required this.uid});

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
    nombre: json["nombre"],
    correo: json["correo"],
    rol: json["rol"],
    estado: json["estado"],
    google: json["google"],
    uid: json["uid"],
  );

  Map<String, dynamic> toMap() => {
    "nombre": nombre,
    "correo": correo,
    "rol": rol,
    "estado": estado,
    "google": google,
    "uid": uid,
  };
}