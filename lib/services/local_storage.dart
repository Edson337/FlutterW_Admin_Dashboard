import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete shared_preferences para guardar y leer datos persistentes en el dispositivo (local storage)

class LocalStorage { // Clase para centralizar el manejo de almacenamiento local
  static late SharedPreferences prefs; // Variable estática que contendrá la instancia de SharedPreferences (será accesible desde toda la app)

  static Future<void> configurePrefs() async { // Método para inicializar la instancia de SharedPreferences (se debe llamar al iniciar la app)
    prefs = await SharedPreferences.getInstance(); // Obtiene la instancia de SharedPreferences de manera asíncrona
  }
}