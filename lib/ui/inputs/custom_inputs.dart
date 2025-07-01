import 'package:flutter/material.dart'; // Importa las herramientas de Flutter para trabajar con widgets visuales

class CustomInputs { // Clase utilitaria para centralizar decoraciones de campos de texto (InputDecoration)
  static InputDecoration loginInputDecoration({required String hint, required String label, required IconData icon}) { // Estilo de input específico para los campos del formulario de Login
    return InputDecoration(
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54)
    );
  }

  static InputDecoration searchInputDecoration({required String hint, required IconData icon}) { // Estilo de input para campos tipo Search (buscador)
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey)      
    );
  }

  static InputDecoration passwordInputDecoration({required String hint, required String label, required bool isObscure, required VoidCallback toggleVisibility}) { // Estilo de input para campos de tipo Password, con visibilidad controlada
    return InputDecoration(
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: const Icon(Icons.lock_outline, color: Colors.white54),
      suffixIcon: IconButton(
        icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.white54),
        onPressed: toggleVisibility,
      ),
    );
  }

  static InputDecoration formInputDecoration({required String hint, required String label, required IconData icon}) { // Estilo de input genérico para formularios del Dashboard
    return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo.withOpacity(0.3))),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: Colors.grey)
    );
  }
}