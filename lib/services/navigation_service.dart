import 'package:flutter/material.dart'; // Importa el paquete de Flutter necesario para la navegación y gestión del estado de las pantallas

class NavigationService { // Clase que proporciona un servicio global para manejar navegación sin necesidad de tener el BuildContext
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); // Clave global que nos permite acceder al Navigator en cualquier parte de la app

  static navigateTo(String routeName) { // Método estático para navegar a una nueva ruta (push)
    return navigatorKey.currentState!.pushNamed(routeName); // Usa el Navigator a través del navigatorKey para navegar a la ruta indicada
  }

  static replaceTo(String routeName) { // Método estático para reemplazar la pantalla actual por otra (pushReplacement)
    return navigatorKey.currentState!.pushReplacementNamed(routeName); // Cambia la pantalla actual por la nueva ruta (ejemplo: después de un login exitoso)
  }
}