import 'package:fluro/fluro.dart'; // Importación del paquete Fluro, que se usa para definir el manejo de rutas (router) en Flutter
import 'package:provider/provider.dart'; // Importación de Provider para acceder a los providers dentro de los handlers

import 'package:admin_dashboard/providers/providers.dart'; // Importación de todos los providers desde un solo archivo centralizado
import 'package:admin_dashboard/ui/ui.dart'; // Importación de las vistas (pantallas) que se mostrarán según el estado de autenticación

class AdminHandlers { // Clase que contiene los handlers específicos para las rutas relacionadas al administrador
  static Handler login = Handler(handlerFunc: (context, params) { // Handler para la ruta de login
    final authProvider = Provider.of<AuthProvider>(context!); // Obtiene el estado de autenticación actual usando el Provider
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView(); // Si el usuario NO está autenticado, muestra la pantalla de Login
    } else {
      return const DashboardView(); // Si ya está autenticado, redirige al Dashboard
    }
  });

  static Handler register = Handler(handlerFunc: (context, params) { // Handler para la ruta de registro
    final authProvider = Provider.of<AuthProvider>(context!); // Igual que en login, verifica si el usuario no está autenticado
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterView(); // Si no está autenticado, muestra la pantalla de registro
    } else {
      return const DashboardView(); // Si ya está autenticado, lo manda al Dashboard
    }
  });
}