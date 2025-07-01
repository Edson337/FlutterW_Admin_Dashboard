import 'dart:typed_data'; // Importación de tipo de dato para manejar arrays de bytes
import 'package:dio/dio.dart'; // Importación de la librería Dio para hacer peticiones HTTP

import 'package:admin_dashboard/services/services.dart'; // Importación de servicios del proyecto (usado para el token guardado en LocalStorage)

class CafeApi { // Clase que centraliza las llamadas HTTP al backend
  static final Dio _dio = Dio(); // Instancia única de Dio para toda la app (Singleton)

  static void configureDio() { // Método para configurar Dio antes de usarlo
    _dio.options.baseUrl = 'http://localhost:8080/api'; // Define la URL base para todas las peticiones HTTP
    _dio.options.headers = { // Agrega el token de autenticación en las cabeceras de todas las peticiones
      'x-token': LocalStorage.prefs.getString('token') ?? '' // Si no hay token, envía cadena vacía
    };
  }

  static Future httpGet(String path) async { // Método estático para hacer peticiones GET
    try {
      final response = await _dio.get(path); // Ejecuta la petición GET al backend
      return response.data; // Retorna solo el cuerpo (data) de la respuesta
    } on DioException catch (err) { // Captura cualquier error en la petición GET
      throw ('Error en el GET: ${err.response}'); // Lanza un mensaje de error
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async { // Método estático para hacer peticiones POST (envío de datos)
    final formData = FormData.fromMap(data); // Convierte el mapa de datos a FormData (útil para multipart/form-data)
    try {
      final response = await _dio.post(path, data: formData); // Ejecuta el POST
      return response.data; // Devuelve el cuerpo de la respuesta
    } on DioException catch (err) {
      throw ('Error en el POST: ${err.response}'); // Manejo de errores
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async { // Método estático para hacer peticiones PUT (actualización de recursos)
    final formData = FormData.fromMap(data); // Convierte los datos a FormData
    try {
      final response = await _dio.put(path, data: formData); // Ejecuta el PUT
      return response.data; // Retorna la data de la respuesta
    } on DioException catch (err) {
      throw ('Error en el PUT: ${err.response}'); // Manejo de error
    }
  }

  static Future httpDelete(String path, Map<String, dynamic> data) async { // Método estático para hacer peticiones DELETE (eliminar recursos)
    final formData = FormData.fromMap(data); // Convierte datos a FormData
    try {
      final response = await _dio.delete(path, data: formData); // Ejecuta el DELETE
      return response.data; // Retorna la respuesta
    } on DioException catch (err) {
      throw ('Error en el DELETE: ${err.response}'); // Manejo de error
    }
  }

  static Future httpUploadFile(String path, Uint8List bytes) async { // Método para subir archivos (upload) al servidor (usando un PUT)
    final formData = FormData.fromMap({
      'archivo': MultipartFile.fromBytes(bytes) // Convierte los bytes del archivo en un MultipartFile
    });
    try {
      final response = await _dio.put(path, data: formData); // Ejecuta el PUT para subir el archivo
      return response.data; // Retorna la respuesta
    } on DioException catch (err) {
      throw ('Error en el PUTUploadImage: ${err.response}'); // Manejo de error
    }
  }
}