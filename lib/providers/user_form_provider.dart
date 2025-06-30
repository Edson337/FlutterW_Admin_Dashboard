import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/CafeApi.dart';
import 'package:admin_dashboard/models/models.dart';

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

  Future<User> uploadImage(Uint8List bytes, String uid) async {
    try {
      final response = await CafeApi.httpUploadFile('/uploads/usuarios/$uid', bytes);
      usuario = User.fromMap(response);
      notifyListeners();
      return usuario!;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}