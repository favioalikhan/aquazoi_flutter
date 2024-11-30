import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/repositories/employee/departamento_repository.dart';
import '../../models/departamento_model.dart';

class DataDepartamentoRepository implements DepartamentoRepository {
  final http.Client client;
  final String baseUrl;

  DataDepartamentoRepository({
    required this.client,
    this.baseUrl = 'https://web-production-0b68.up.railway.app/api',
  });

  @override
  Future<List<DepartamentoModel>> getDepartamentos() async {
    final response = await client.get(
      Uri.parse('$baseUrl/departamentos/'),
    );
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      List<dynamic> data = json.decode(decodedBody);
      return data.map((json) => DepartamentoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener departamentos: ${response.statusCode}');
    }
  }
}
