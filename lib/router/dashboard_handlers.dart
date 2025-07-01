import 'package:fluro/fluro.dart'; // Importa Fluro para la configuración del enrutamiento
import 'package:provider/provider.dart'; // Importa Provider para acceder a los Providers dentro de los handlers

import 'package:admin_dashboard/router/router.dart'; // Importa el archivo de rutas personalizado (donde están las rutas nombradas)
import 'package:admin_dashboard/providers/providers.dart'; // Importa todos los Providers centralizados (AuthProvider, SideMenuProvider, etc.)
import 'package:admin_dashboard/ui/ui.dart'; // Importa todas las vistas del UI

class DashboardHandlers { // Clase que contiene los handlers de rutas para el dashboard y sus secciones
  static Handler dashboard = Handler(handlerFunc: (context, params) { // Handler para la ruta del Dashboard principal
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.dashboardRoute); // Actualiza la URL actual en el menú lateral
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView(); // Si el usuario está autenticado, muestra el Dashboard
    } else {
      return const LoginView(); // Si no, lo redirige al Login
    }
  });

  static Handler icons = Handler(handlerFunc: (context, params) { // Handler para la ruta de íconos (IconsView)
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.iconsRoute); // Actualiza la ruta actual en el SideMenu
    if (authProvider.authStatus == AuthStatus.authenticated) { // Verifica autenticación
      return const IconsView();
    } else {
      return const LoginView();
    }
  });

  static Handler blank = Handler(handlerFunc: (context, params) { // Handler para la vista en blanco (BlankView)
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.blankRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const BlankView();
    } else {
      return const LoginView();
    }
  });

  static Handler categories = Handler(handlerFunc: (context, params) { // Handler para la vista de categorías (CategoriesView)
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.categoriesRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CategoriesView();
    } else {
      return const LoginView();
    }
  });

  static Handler users = Handler(handlerFunc: (context, params) { // Handler para la vista de usuarios (UsersView)
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.usersRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UsersView();
    } else {
      return const LoginView();
    }
  });

  static Handler user = Handler(handlerFunc: (context, params) { // Handler para la vista de detalle/edición de un usuario individual
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.userRoute);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']?.first != null) { // Extrae el parámetro dinámico "uid" desde la URL
        final String uid = params['uid']!.first;
        return UserView(uid: uid); // Retorna la vista del usuario con el UID correspondiente
      } else {
        return const UsersView(); // Si no viene el uid, redirige a la lista de usuarios
      }
    } else {
      return const LoginView(); // Si el usuario no está autenticado, lo lleva al Login
    }
  });
}