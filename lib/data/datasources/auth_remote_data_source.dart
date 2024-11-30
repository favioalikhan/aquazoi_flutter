// lib/data/datasources/auth_remote_data_source.dart
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> authenticate(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final FlutterSecureStorage storage;

  AuthRemoteDataSourceImpl({required this.client})
      : storage = const FlutterSecureStorage();

  @override
  Future<UserModel> authenticate(String email, String password) async {
    try {
      print('Attempting login with email: $email'); // Debug print
      final response = await client.post(
        Uri.parse('https://web-production-0b68.up.railway.app/api/token/'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'email': email.trim(), 'password': password}),
      );
      print('Response status code: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);

        // Verificar si el usuario tiene acceso al sistema
        if (data.containsKey('acceso_sistema') &&
            data['acceso_sistema'] == false) {
          throw Exception('No tiene permisos para acceder al sistema.');
        }

        final userData = UserModel.fromJson(data);

        return userData;
      } else {
        String errorMessage;
        try {
          final errorData = json.decode(response.body);
          errorMessage = errorData['detail'] ?? 'Error de autenticación';
        } catch (e) {
          // Si no podemos decodificar el JSON, usar el cuerpo de la respuesta
          errorMessage = response.body;
        }

        if (response.statusCode == 500) {
          throw Exception('Error interno del servidor: $errorMessage');
        } else if (response.statusCode == 401) {
          throw Exception('Credenciales inválidas');
        } else {
          throw Exception('Error de autenticación: $errorMessage');
        }
      }
    } on FormatException catch (e) {
      throw Exception('Error en el formato de la respuesta: $e');
    } on http.ClientException catch (e) {
      throw Exception('Error de conexión: $e');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
