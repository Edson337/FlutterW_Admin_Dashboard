import 'package:dio/dio.dart';

import '../services/local_storage.dart';

class CafeApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = 'http://localhost:8080/api';
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }

  static Future httpGet(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioException catch (err) {
      throw ('Error en el GET: ${err.response}');
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.post(path, data: formData);
      return response.data;
    } on DioException catch (err) {
      throw ('Error en el POST: ${err.response}');
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.put(path, data: formData);
      return response.data;
    } on DioException catch (err) {
      throw ('Error en el PUT: ${err.response}');
    }
  }

  static Future httpDelete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final response = await _dio.delete(path, data: formData);
      return response.data;
    } on DioException catch (err) {
      throw ('Error en el DELETE: ${err.response}');
    }
  }
}