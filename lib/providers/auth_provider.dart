import 'package:flutter/material.dart';

import '../api/CafeApi.dart';
import '../models/http/auth_response.dart';
import '../router/router.dart';
import '../services/local_storage.dart';
import '../services/navigation_service.dart';
import '../services/notifications_service.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    final data = {'correo': email, 'password': password};
    CafeApi.httpPost('/auth/login', data).then((json) {
      print(json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      CafeApi.configureDio();
      notifyListeners();
    }).catchError((err) {
      print('Error: $err');
      NotificationsService.showSnackBarError('No se ha encontrado una cuenta con ese correo electrónico.');
    });
  }

  register(String name, String email, String password) {
    final data = {'nombre': name, 'correo': email, 'password': password};
    CafeApi.httpPost('/usuarios', data).then((json) {
      print(json);
      final authResponse = AuthResponse.fromMap(json);
      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      CafeApi.configureDio();
      notifyListeners();
    }).catchError((err) {
      print('Error: $err');
      NotificationsService.showSnackBarError('Ya existe una cuenta con este correo electrónico.');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    try {
      final response = await CafeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(response);
      LocalStorage.prefs.setString('token', authResponse.token);
      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
    return true;
    } catch (err) {
      print('Error: $err');
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}