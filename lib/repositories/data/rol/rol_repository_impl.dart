import '../../../models/data_model/rol_model.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/endpoints.dart';
import 'rol_repository.dart';

class RolRepositoryImpl implements RolRepository {
  final ApiClient apiClient;

  RolRepositoryImpl(this.apiClient);

  @override
  Future<List<RolModel>> getRoles(RolModel rol) async {
    if (rol.departamentoId == null) {
      throw Exception(
          'El departamento o su ID es requerido para obtener roles');
    }

    final response = await apiClient
        .get(ApiEndpoints.rolesPorDepartamento(rol.departamentoId!));

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((rolJson) => RolModel.fromJson(rolJson))
          .toList();
    } else {
      throw Exception('Error al obtener roles: ${response.data['detail']}');
    }
  }
}
