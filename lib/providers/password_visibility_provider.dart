import 'package:flutter/material.dart'; // Importa el paquete de Flutter necesario para el manejo de estado

class PasswordVisibilityProvider with ChangeNotifier { // Provider para manejar la visibilidad del campo de contraseña
  bool _isObscure = true; // Estado interno que indica si la contraseña está oculta o visible
  bool get isObscure => _isObscure; // Getter para exponer el estado actual de la visibilidad
  
  void toggleVisibility() { // Método para cambiar el estado de visibilidad
    _isObscure = !_isObscure; // Cambia el valor (true -> false o viceversa)
    notifyListeners(); // Notifica a los widgets que estén escuchando que el estado cambió
  }
}