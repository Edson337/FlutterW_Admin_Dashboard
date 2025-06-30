import 'dart:convert';

import 'package:admin_dashboard/models/models.dart';

class AuthResponse {
  User usuario;
  String token;

  AuthResponse({required this.usuario, required this.token});

  factory AuthResponse.fromJson(String str) => AuthResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
    usuario: User.fromMap(json["usuario"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "usuario": usuario.toMap(),
    "token": token,
  };
}