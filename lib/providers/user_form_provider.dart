import 'package:flutter/material.dart';

import '../api/CafeApi.dart';
import '../models/http/user.dart';

class UserFormProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;
  User? usuario;

  // void updateListener() {
  //   notifyListeners();
  // }

  copyUserWith({String? nombre, String? correo, String? rol, bool? estado, bool? google, String? uid, String? img}) {
    usuario = User(
      nombre: nombre ?? usuario!.nombre, 
      correo: correo ?? usuario!.correo, 
      rol: rol ?? usuario!.rol, 
      estado: estado ?? usuario!.estado, 
      google: google ?? usuario!.google, 
      uid: uid ?? usuario!.uid,
      img: img ?? usuario!.img
    );
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser() async {
    if (!_validForm()) return false;
    final data = {
      'nombre': usuario!.nombre,
      'correo': usuario!.correo,
    };
    try {
      await CafeApi.httpPut('/usuarios/${usuario!.uid}', data);
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }
}