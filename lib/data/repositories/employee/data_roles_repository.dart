import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../domain/repositories/employee/rol_repository.dart';
import '../../models/rol_model.dart';

class DataRolRepository implements RolRepository {
  final http.Client client;
  final String baseUrl;

  DataRolRepository(
      {required this.client,
      this.baseUrl = 'https://web-production-0b68.up.railway.app'});

  @override
  Future<List<RolDetailModel>> getRolesByDepartamento(
      int departamentoId) async {
    final response = await client
        .get(Uri.parse('$baseUrl/departamentos/$departamentoId/roles/'));
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      List<dynamic> data = json.decode(decodedBody);
      return data.map((json) => RolDetailModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener roles: ${response.statusCode}');
    }
  }
}
