import 'package:fluro/fluro.dart'; // Importa Fluro: paquete para manejo avanzado de rutas (routing) en Flutter

import 'package:admin_dashboard/router/routes.dart'; // Importa las definiciones de todos los Handlers creados previamente

class Flurorouter { // Clase central que configura todas las rutas de la aplicación
  static final FluroRouter router = FluroRouter(); // Instancia estática única del router que será usada en toda la app
  static String rootRoute = '/'; // Ruta raíz (página por defecto al iniciar la app)

  // RUTAS PARA AUTENTICACIÓN
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // RUTAS DEL DASHBOARD
  static String dashboardRoute = '/dashboard';
  static String iconsRoute = '/dashboard/icons';
  static String blankRoute = '/dashboard/blank';
  static String categoriesRoute = '/dashboard/categories';
  static String usersRoute = '/dashboard/users';
  static String userRoute = '/dashboard/users/:uid';

  static void configureRoutes() { // Método donde se configuran todas las rutas y se enlazan con sus handlers
    // RUTAS DE AUTENTICACIÓN
    router.define(rootRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none);

    // RUTAS DEL DASHBOARD
    router.define(dashboardRoute, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn);
    router.define(iconsRoute, handler: DashboardHandlers.icons, transitionType: TransitionType.fadeIn);
    router.define(blankRoute, handler: DashboardHandlers.blank, transitionType: TransitionType.fadeIn);
    router.define(categoriesRoute, handler: DashboardHandlers.categories, transitionType: TransitionType.fadeIn);
    router.define(usersRoute, handler: DashboardHandlers.users, transitionType: TransitionType.fadeIn);
    router.define(userRoute, handler: DashboardHandlers.user, transitionType: TransitionType.fadeIn);

    // RUTA PARA 404 (Not Found)
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}