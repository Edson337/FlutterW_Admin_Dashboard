import 'package:fluro/fluro.dart'; // Importa Fluro para el manejo de rutas y configuración de Handlers
import 'package:provider/provider.dart'; // Importa Provider para poder acceder al estado de los Providers dentro del Handler

import 'package:admin_dashboard/providers/providers.dart'; // Importa todos los Providers centralizados (en este caso, usamos SideMenuProvider)
import 'package:admin_dashboard/ui/ui.dart'; // Importa las vistas del UI (en este caso, la vista para páginas no encontradas)

class NoPageFoundHandlers { // Clase encargada de manejar las rutas que no existen (404 Not Found)
  static Handler noPageFound = Handler(handlerFunc: (context, params) { // Handler que devuelve la vista de "No Page Found" cuando la ruta no coincide con ninguna existente
    Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPageUrl('/404'); // Actualiza la URL actual en el SideMenu para reflejar que estamos en la ruta 404
    return const NoPageFoundView(); // Retorna la vista personalizada de página no encontrada
  });
}