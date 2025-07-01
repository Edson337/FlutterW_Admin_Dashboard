import 'package:flutter/material.dart'; // Importa el paquete de Flutter para manejar widgets y formularios

class LoginFormProvider extends ChangeNotifier { // Provider que maneja el estado del formulario de login
  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Clave global que permite identificar el estado del formulario en la UI
  String email = ''; // Variables para almacenar los valores del formulario (email y contraseña)
  String password = '';

  bool validateForm() { // Método para validar el formulario
    if (formKey.currentState!.validate()) { // Llama al método validate del formulario actual
      return true; // Si todas las validaciones de los campos pasan, devuelve true
    } else {
      return false; // Si alguna validación falla, devuelve false
    }
  }
}