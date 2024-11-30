// lib/data/repositories/data_employee_repository.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/entities/employee.dart';
import '../../../domain/repositories/employee/employee_repository.dart';
import '../../models/employee_model.dart';

class DataEmpleadoRepository implements EmpleadoRepository {
  final http.Client client;
  final String baseUrl;

  DataEmpleadoRepository(
      {required this.client,
      this.baseUrl = 'https://web-production-0b68.up.railway.app/api'});

  @override
  Future<List<Empleado>> getEmpleados({
    int? page,
    int? limit,
    String? filter,
  }) async {
    final queryParameters = {
      if (page != null) 'page': page.toString(),
      if (limit != null) 'limit': limit.toString(),
      if (filter != null) 'filter': filter,
    };
    final response = await client.get(
      Uri.parse('https://web-production-0b68.up.railway.app/api/empleados/')
          .replace(queryParameters: queryParameters),
    );
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      print('Response body: ${response.body}');
      List<dynamic> data = json.decode(decodedBody);
      return data.map((json) => EmpleadoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener empleados:  ${response.statusCode}');
    }
  }
}
