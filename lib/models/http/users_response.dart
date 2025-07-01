import 'dart:convert'; // Importa dart:convert para manejo de JSON

import 'package:admin_dashboard/models/models.dart'; // Importa el modelo User para mapear los datos de usuarios

class UsersResponse { // Clase que representa la respuesta del backend con la lista de usuarios
    int total; // Total de usuarios, útil para paginación
    List<User> usuarios; // Lista de objetos User

    UsersResponse({required this.total, required this.usuarios});

    factory UsersResponse.fromJson(String str) => UsersResponse.fromMap(json.decode(str)); // Factory para crear una instancia desde un JSON string

    String toJson() => json.encode(toMap()); // Convierte la instancia a un JSON string

    factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse( // Factory para crear una instancia desde un Map<String, dynamic>
      total: json["total"],
      usuarios: List<User>.from(json["usuarios"].map((x) => User.fromMap(x))),
    );

    Map<String, dynamic> toMap() => { // Convierte la instancia actual a un Map<String, dynamic> para serializar
      "total": total,
      "usuarios": List<dynamic>.from(usuarios.map((x) => x.toMap())),
    };
}