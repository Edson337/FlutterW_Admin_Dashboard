import 'package:flutter/material.dart'; // Importación del paquete Flutter para el manejo de estado

import 'package:admin_dashboard/api/CafeApi.dart'; // Importación de la API personalizada para hacer peticiones HTTP
import 'package:admin_dashboard/models/models.dart'; // Importación de los modelos necesarios (User, UsersResponse, etc.)

class UsersProvider extends ChangeNotifier { // Provider encargado de manejar el estado de la lista de usuarios
  List<User> users = []; // Lista de usuarios cargados desde el backend
  bool isLoading = true; // Estado para indicar si los datos aún están cargando
  bool ascending = true; // Estado para controlar el ordenamiento ascendente o descendente
  int? sortColumnIndex; // Índice de la columna por la que se está ordenando actualmente

  UsersProvider() { // Constructor: Al crear este provider, automáticamente carga los usuarios
    getPaginatedUsers();
  }

  getPaginatedUsers() async { // Método para obtener una lista paginada de usuarios
    final response = await CafeApi.httpGet('/usuarios?limite=100&desde=0'); // Hace un GET al backend, solicitando 100 usuarios desde el índice 0
    final userReponse = UsersResponse.fromMap(response); // Parsea la respuesta a un objeto UsersResponse
    users = [...userReponse.usuarios]; // Actualiza la lista local de usuarios
    isLoading = false; // Marca que la carga terminó
    notifyListeners(); // Notifica a la UI que los datos ya están listos
  }

  Future<User?> getUserById(String uid) async { // Método para obtener un usuario individual por su UID
    try {
      final response = await CafeApi.httpGet('/usuarios/$uid'); // Llama al endpoint GET /usuarios/{uid}
      final user = User.fromMap(response); // Parsea la respuesta y devuelve el usuario
      return user;
    } catch (e) {
      print('Error fetching user with ID $uid: $e'); // Si hay error, lo muestra en consola y devuelve null
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(User user) getField) { // Método genérico para ordenar la lista de usuarios por cualquier campo
    users.sort((a, b) { // Ordena la lista de usuarios
      final aValue = getField(a); // Obtiene el valor del campo en el usuario A
      final bValue = getField(b); // Obtiene el valor del campo en el usuario B
      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue); // Compara dependiendo de si el orden es ascendente o descendente
    });
    ascending = !ascending; // Invierte el orden para la próxima vez que se ordene
    notifyListeners(); // Notifica a la UI para que actualice el orden mostrado
  }

  void refreshUser(User newUser) { // Método para actualizar un usuario en la lista local (sin ir al backend)
    users = users.map((user) {
      if (user.uid == newUser.uid) return newUser; // Si el UID coincide, reemplaza por el nuevo usuario actualizado
      return user; // Si no coincide, deja el usuario como estaba
    }).toList();
    notifyListeners(); // Notifica a la UI que la lista cambió
  }
}