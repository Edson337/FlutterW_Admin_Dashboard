import 'dart:convert';

import 'package:admin_dashboard/models/models.dart';

class UsersResponse {
    int total;
    List<User> usuarios;

    UsersResponse({required this.total, required this.usuarios});

    factory UsersResponse.fromJson(String str) => UsersResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        total: json["total"],
        usuarios: List<User>.from(json["usuarios"].map((x) => User.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toMap())),
    };
}