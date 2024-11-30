import 'dart:convert';

import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'https://web-production-0b68.up.railway.app/api',
            connectTimeout: Duration(days: 1),
            receiveTimeout: Duration(days: 1),
          ),
        );

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } on DioException catch (e) {
      // Puedes agregar un log aquí si es necesario
      print("Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
        print("Response code: ${e.response?.statusCode}");
      }
      throw Exception(
          e.response?.data['detail'] ?? 'Error en la solicitud: ${e.message}');
    }
  }

  Future<Response> get(String endpoint) async {
    try {
      final response = await _dio.get(
        endpoint,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['detail'] ?? 'Error en la solicitud: ${e.message}');
    }
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } on DioException catch (e) {
      print("Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
        print("Response code: ${e.response?.statusCode}");
      }
      throw Exception(
          e.response?.data['detail'] ?? 'Error en la solicitud: ${e.message}');
    }
  }

  // Método PATCH para actualización parcial
  Future<Response> patch(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: jsonEncode(data),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } on DioException catch (e) {
      print("Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
        print("Response code: ${e.response?.statusCode}");
      }
      throw Exception(
          e.response?.data['detail'] ?? 'Error en la solicitud: ${e.message}');
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      final response = await _dio.delete(
        endpoint,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } on DioException catch (e) {
      print("Error: ${e.message}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
        print("Response code: ${e.response?.statusCode}");
      }
      throw Exception(
          e.response?.data['detail'] ?? 'Error en la solicitud: ${e.message}');
    }
  }
}
