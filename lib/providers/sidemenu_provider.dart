import 'package:flutter/material.dart'; // Importa Flutter para manejo de widgets, animaciones y ChangeNotifier

class SideMenuProvider extends ChangeNotifier { // Provider encargado de manejar el estado del Side Menu (menú lateral)
  static late AnimationController menuController; // Controlador de animaciones para controlar la animación de abrir/cerrar el menú
  static bool isOpen = false; // Estado que indica si el menú está abierto o cerrado

  String _currentPage = ''; // Variable privada para almacenar la página actual seleccionada

  String get currentPage { // Getter para obtener la página actual
    return _currentPage;
  }

  void setCurrentPageUrl(String routeName) { // Método para cambiar la ruta/página actual
    _currentPage = routeName;
    Future.delayed(const Duration(milliseconds: 100), () { // Espera 100 ms antes de notificar (puede ser para evitar problemas de sincronización)
      notifyListeners(); // Notifica a los widgets que estén escuchando
    });
  }

  static Animation<double> movement = Tween<double>(begin: -200, end: 0).animate( // Animación que controla el movimiento (desplazamiento) del menú
    CurvedAnimation(parent: menuController, curve: Curves.easeInOut));
  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate( // Animación que controla la opacidad del menú (fade in / fade out)
    CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() { // Método para abrir el menú lateral
    isOpen = true; // Cambia el estado a abierto
    menuController.forward(); // Ejecuta la animación hacia adelante
  }

  static void closeMenu() { // Método para cerrar el menú lateral
    isOpen = false; // Cambia el estado a cerrado
    menuController.reverse(); // Ejecuta la animación en reversa
  }

  static void toggleMenu() { // Método para alternar entre abrir y cerrar el menú
    (isOpen) ? menuController.reverse() : menuController.forward();
    isOpen = !isOpen; // Cambia el estado
  }
}