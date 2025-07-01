import 'dart:typed_data'; // Importa tipos para manejar bytes (necesario para subir imágenes)
import 'package:flutter/material.dart'; // Importa Flutter para manejo de estado y formularios

import 'package:admin_dashboard/api/CafeApi.dart'; // Importa la clase que maneja las peticiones HTTP (API personalizada)
import 'package:admin_dashboard/models/models.dart'; // Importa los modelos (User, etc.)

class UserFormProvider extends ChangeNotifier { // Provider encargado de manejar el formulario de edición de usuario
  late GlobalKey<FormState> formKey; // Clave global para acceder al estado del formulario desde la UI
  User? usuario; // Usuario que se está editando o manipulando en el formulario

  // void updateListener() { // Método comentado que en su momento pudo usarse para forzar notificar listeners
  //   notifyListeners();
  // }

  // Método para actualizar el objeto usuario manteniendo los campos existentes
  copyUserWith({String? nombre, String? correo, String? rol, bool? estado, bool? google, String? uid, String? img}) {
    usuario = User( // Si el nuevo nombre es null, conserva el actual
      nombre: nombre ?? usuario!.nombre, 
      correo: correo ?? usuario!.correo, 
      rol: rol ?? usuario!.rol, 
      estado: estado ?? usuario!.estado, 
      google: google ?? usuario!.google, 
      uid: uid ?? usuario!.uid,
      img: img ?? usuario!.img
    );
    notifyListeners(); // Notifica a los widgets que el usuario ha cambiado
  }

  bool _validForm() { // Método privado para validar el formulario (usando los validadores de TextFormField)
    return formKey.currentState!.validate();
  }

  Future updateUser() async { // Método para actualizar el usuario en el backend
    if (!_validForm()) return false; // Si el formulario no es válido, retorna false
    final data = { // Construye el cuerpo del request con los campos que se pueden actualizar
      'nombre': usuario!.nombre,
      'correo': usuario!.correo,
    };
    try {
      await CafeApi.httpPut('/usuarios/${usuario!.uid}', data); // Realiza el PUT hacia el endpoint de actualización del usuario
      return true; // Indica que se actualizó correctamente
    } catch (e) {
      print('Error updating user: $e'); // En caso de error, muestra el mensaje en consola
      return false; // Indica que falló
    }
  }

  Future<User> uploadImage(Uint8List bytes, String uid) async { // Método para subir una imagen (por ejemplo, la foto de perfil del usuario)
    try {
      final response = await CafeApi.httpUploadFile('/uploads/usuarios/$uid', bytes); // Realiza el upload llamando a la API
      usuario = User.fromMap(response); // Actualiza el usuario localmente con la respuesta que viene del backend
      notifyListeners(); // Notifica a los widgets para que actualicen la imagen mostrada
      return usuario!;
    } catch (e) {
      throw Exception('Error uploading image: $e'); // Si ocurre un error, lanza una excepción
    }
  }
}