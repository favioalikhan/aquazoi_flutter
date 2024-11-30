// lib/data/datasources/employee_remote_data_source.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class EmployeeRemoteDataSource {
  Future<void> registerEmployee(
      {required String token,
      required String nombre,
      required String apellido,
      required String email,
      required String telefono,
      required String direccion,
      required DateTime fechaContratacion,
      required String puesto});
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final http.Client client;

  EmployeeRemoteDataSourceImpl({required this.client});

  @override
  Future<void> registerEmployee(
      {required String token,
      required String nombre,
      required String apellido,
      required String email,
      required String telefono,
      required String direccion,
      required DateTime fechaContratacion,
      required String puesto}) async {
    final response = await client.post(
      Uri.parse(
          'https://web-production-0b68.up.railway.app/api/empleados/registro/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'telefono': telefono,
        'direccion': direccion,
        'fechaContratacion': fechaContratacion,
        'puesto': puesto,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al registrar empleado');
    }
  }
}
