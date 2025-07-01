import 'package:flutter/material.dart'; // Importación de Flutter para manejo de estado y widgets

import 'package:admin_dashboard/api/CafeApi.dart'; // Importación de la clase que maneja las peticiones HTTP
import 'package:admin_dashboard/router/router.dart'; // Importación del sistema de rutas personalizadas
import 'package:admin_dashboard/models/models.dart'; // Importación de modelos (incluyendo AuthResponse y User)
import 'package:admin_dashboard/services/services.dart'; // Importación de servicios como LocalStorage y NotificationsService

enum AuthStatus {checking, authenticated, notAuthenticated} // Enum que representa los posibles estados de autenticación

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking; // Estado actual de autenticación
  User? user; // Usuario actualmente autenticado (puede ser null si no hay sesión)

  AuthProvider() { // Constructor que llama a isAuthenticated al inicializar el provider
    isAuthenticated();
  }

  login(String email, String password) { // Método para iniciar sesión (login)
    final data = {'correo': email, 'password': password}; // Cuerpo del request POST
    CafeApi.httpPost('/auth/login', data).then((json) { // Realiza la petición POST al endpoint de login
      final authResponse = AuthResponse.fromMap(json); // Si la respuesta es exitosa, parsea el JSON a un AuthResponse
      user = authResponse.usuario; // Guarda el usuario en memoria
      authStatus = AuthStatus.authenticated; // Actualiza el estado de autenticación
      LocalStorage.prefs.setString('token', authResponse.token); // Guarda el token localmente para futuras sesiones
      NavigationService.replaceTo(Flurorouter.dashboardRoute); // Redirige al dashboard después de loguearse
      CafeApi.configureDio(); // Reconfigura Dio para incluir el nuevo token en las cabeceras
      notifyListeners(); // Notifica a los widgets que estén escuchando cambios
    }).catchError((err) {
      print('Error: $err'); // Si ocurre un error (credenciales incorrectas u otro fallo)
      NotificationsService.showSnackBarError('No se ha encontrado una cuenta con ese correo electrónico.'); // Muestra un mensaje de error en forma de snackbar
    });
  }

  register(String name, String email, String password) { // Método para registrar un nuevo usuario
    final data = {'nombre': name, 'correo': email, 'password': password}; // Cuerpo del request POST
    CafeApi.httpPost('/usuarios', data).then((json) { // Hace la petición POST al endpoint de registro de usuario
      final authResponse = AuthResponse.fromMap(json); // Si la respuesta es exitosa, parsea el JSON a AuthResponse
      user = authResponse.usuario; // Guarda el usuario en memoria
      authStatus = AuthStatus.authenticated; // Cambia el estado a autenticado
      LocalStorage.prefs.setString('token', authResponse.token); // Guarda el token recibido
      NavigationService.replaceTo(Flurorouter.dashboardRoute); // Redirige al dashboard
      CafeApi.configureDio(); // Reconfigura Dio para futuras peticiones con el nuevo token
      notifyListeners(); // Notifica a los listeners (widgets)
    }).catchError((err) {
      print('Error: $err'); // Si ocurre error al registrar (correo ya existe u otro fallo)
      NotificationsService.showSnackBarError('Ya existe una cuenta con este correo electrónico.'); // Muestra mensaje de error
    });
  }

  Future<bool> isAuthenticated() async { // Método para verificar si el usuario ya está autenticado
    final token = LocalStorage.prefs.getString('token'); // Obtiene el token almacenado localmente
    if (token == null) { // Si no hay token, se considera no autenticado
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    try {
      final response = await CafeApi.httpGet('/auth'); // Intenta validar el token haciendo una petición GET a /auth
      final authResponse = AuthResponse.fromMap(response); // Parsea la respuesta
      LocalStorage.prefs.setString('token', authResponse.token); // Actualiza el token por si el backend devolvió uno nuevo
      user = authResponse.usuario; // Guarda el usuario en memoria
      authStatus = AuthStatus.authenticated; // Cambia el estado a autenticado
      notifyListeners();
      return true; // Retorna que sí está autenticado
    } catch (err) {
      print('Error: $err'); // Si ocurre un error (token inválido o expirado)
      authStatus = AuthStatus.notAuthenticated; // Cambia el estado a no autenticado
      notifyListeners();
      return false; // Retorna que no está autenticado
    }
  }

  logout() { // Método para cerrar sesión
    LocalStorage.prefs.remove('token'); // Borra el token guardado localmente
    authStatus = AuthStatus.notAuthenticated; // Cambia el estado a no autenticado
    notifyListeners(); // Notifica a los listeners para que la UI cambie
  }
}