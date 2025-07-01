import 'package:flutter/material.dart'; // Importa el paquete de Flutter necesario para mostrar SnackBars y diálogos

class NotificationsService { // Servicio para mostrar notificaciones en la aplicación (SnackBars y diálogos de carga)
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>(); // Clave global para acceder al ScaffoldMessenger desde cualquier parte de la app

  static showSnackBarError(String message) { // Método para mostrar una notificación de error como SnackBar
    final snackBar = SnackBar( // Crea el SnackBar con fondo rojo y texto blanco
      backgroundColor: Colors.red.withOpacity(0.8),
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 20))
    );
    messengerKey.currentState!.showSnackBar(snackBar); // Muestra el SnackBar usando el messengerKey global
  }

  static showSnackBarSuccess(String message) { // Método para mostrar una notificación de éxito como SnackBar
    final snackBar = SnackBar( // Crea el SnackBar con fondo verde y texto negro
      backgroundColor: Colors.green.withOpacity(0.8),
      content: Text(message, style: const TextStyle(color: Colors.black, fontSize: 20))
    );
    messengerKey.currentState!.showSnackBar(snackBar); // Muestra el SnackBar usando el messengerKey global
  }

  static showBusyIndicator(BuildContext context) { // Método para mostrar un indicador de carga (spinner) en pantalla
    showDialog( // Muestra un diálogo modal con un CircularProgressIndicator
      context: context,
      barrierDismissible: false, // Impide que el usuario cierre el diálogo tocando fuera
      barrierColor: Colors.black.withOpacity(0.3), // Color semitransparente detrás del diálogo
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          color: Colors.indigo,
          strokeWidth: 3.0, // Grosor de la línea de progreso
        ),
      ),
    );
  }
}