import 'package:flutter/material.dart'; // Importa el paquete de Flutter necesario para la gestión del estado y formularios

class RegisterFormProvider extends ChangeNotifier { // Provider para manejar el estado del formulario de registro
  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Clave global para acceder al estado del formulario en la UI
  String name = ''; // Variables para almacenar temporalmente los valores ingresados en el formulario
  String email = '';
  String password = '';

  validateForm() { // Método para validar el formulario
    if (formKey.currentState!.validate()) { // Verifica si todos los campos del formulario cumplen sus validaciones
      return true; // Si todo es válido, retorna true
    } else {
      return false; // Si alguna validación falla, retorna false
    }
  }
}