import 'dart:convert'; // Importación para poder codificar y decodificar JSON

import 'package:admin_dashboard/models/models.dart'; // Importación del modelo User (representación del usuario)

class AuthResponse { // Clase que representa la respuesta de autenticación del backend
  User usuario; // Atributo que representa el usuario autenticado
  String token; // Token de autenticación recibido del backend

  AuthResponse({required this.usuario, required this.token});

  // Método factory para crear una instancia de AuthResponse a partir de un String JSON
  factory AuthResponse.fromJson(String str) => AuthResponse.fromMap(json.decode(str)); // Decodifica el JSON y lo transforma a mapa, luego a AuthResponse

  // Convierte la instancia actual de AuthResponse a un String JSON
  String toJson() => json.encode(toMap()); // Convierte primero a Map, luego lo codifica como JSON string

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse( // Factory constructor para crear AuthResponse a partir de un Map
    usuario: User.fromMap(json["usuario"]), // Crea un User desde el campo 'usuario' del mapa
    token: json["token"], // Extrae el token directamente
  );

  Map<String, dynamic> toMap() => { // Convierte la instancia actual de AuthResponse a un Map<String, dynamic>
    "usuario": usuario.toMap(), // Convierte el usuario a Map
    "token": token, // Token en formato simple
  };
}