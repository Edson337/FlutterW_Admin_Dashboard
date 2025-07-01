// Importación de librerías y paquetes necesarios de Flutter y de tu proyecto
import 'package:flutter/material.dart'; // Librería principal de Flutter para UI
import 'package:provider/provider.dart'; // Para el manejo de estado con Provider
import 'package:flutter_web_plugins/flutter_web_plugins.dart'; // Para configurar la estrategia de URL en Flutter Web

// Importación de módulos internos del proyecto
import 'package:admin_dashboard/api/CafeApi.dart'; // Configuración de la API (cliente Dio)
import 'package:admin_dashboard/providers/providers.dart'; // Importación centralizada de todos los Providers
import 'package:admin_dashboard/router/router.dart'; // Archivo donde se configura Fluro Router
import 'package:admin_dashboard/services/services.dart'; // Servicios como NavigationService, NotificationsService, etc.
import 'package:admin_dashboard/ui/ui.dart'; // Layouts, temas, widgets de UI personalizados, etc.

void main() async {
  setUrlStrategy(PathUrlStrategy()); // Elimina el "#" de las URLs en Flutter Web para URLs limpias (ejemplo: /login en lugar de /#/login)
  await LocalStorage.configurePrefs(); // Inicializa el almacenamiento local usando SharedPreferences o similar
  CafeApi.configureDio(); // Configura el cliente HTTP Dio (interceptores, baseURL, etc.)
  Flurorouter.configureRoutes(); // Registra todas las rutas de la aplicación usando Fluro
  runApp(const AppState()); // Lanza la aplicación dentro del widget AppState
}

// Clase AppState: Configura todos los Providers a nivel global
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()), // Provider para la autenticación del usuario
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()), // Provider para el estado del menú lateral (Side Menu)
        ChangeNotifierProvider(create: (_) => CategoriesProvider()), // Provider para la gestión de categorías (ej: CRUD de categorías)
        ChangeNotifierProvider(create: (_) => UsersProvider()), // Provider para la gestión de usuarios (ej: listado, edición)
        ChangeNotifierProvider(create: (_) => UserFormProvider()) // Provider para el formulario de edición de usuarios
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Elimina la bandera de "Debug" de la esquina superior derecha
      title: 'Admin Dashboard',
      initialRoute: '/', // Ruta inicial cuando carga la app
      onGenerateRoute: Flurorouter.router.generator, // Generador de rutas usando Fluro Router
      navigatorKey: NavigationService.navigatorKey, // Clave global para navegación desde cualquier parte sin contexto
      scaffoldMessengerKey: NotificationsService.messengerKey, // Clave para mostrar Snackbars globalmente
      builder: (_, child) { // Builder que define el layout base según el estado de autenticación
        final authProvider = Provider.of<AuthProvider>(context); // Obtiene el estado actual de autenticación
        if (authProvider.authStatus == AuthStatus.checking) return const SplashLayout(); // Muestra un Splash mientras se verifica el estado de autenticación
        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!); // Si el usuario está autenticado, carga el layout del Dashboard
        } else {
          return AuthLayout(child: child!); // Si no está autenticado, muestra el layout de autenticación (login, etc.)
        }
      },
      theme: ThemeData.light().copyWith( // Configuración del tema visual
        scrollbarTheme: const ScrollbarThemeData().copyWith(thumbColor: WidgetStateProperty.all(Colors.white30))
      ),
    );
  }
}