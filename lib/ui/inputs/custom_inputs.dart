import 'package:flutter/material.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({required String hint, required String label, required IconData icon}) {
    return InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54)
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54)
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54)
    );
  }
}