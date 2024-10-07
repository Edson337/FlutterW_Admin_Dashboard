import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({required String hint, required String label, required IconData icon}) {
    return InputDecoration(
      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white54)),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      prefixIcon: Icon(icon, color: Colors.white54));
  }

  static InputDecoration searchInputDecoration({required String hint, required IconData icon}) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey),
      labelStyle: const TextStyle(color: Colors.grey),
      hintStyle: const TextStyle(color: Colors.grey)      
    );
  }
}
