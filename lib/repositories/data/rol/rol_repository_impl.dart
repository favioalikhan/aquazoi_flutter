import '../../../models/data_model/rol_model.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/endpoints.dart';
import 'rol_repository.dart';

class RolRepositoryImpl implements RolRepository {
  final ApiClient apiClient;

  RolRepositoryImpl(this.apiClient);

  @override
  Future<List<RolModel>> getRoles(int departamentoId) async {
    final response =
        await apiClient.get(ApiEndpoints.rolesPorDepartamento(departamentoId));

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((rolJson) => RolModel.fromJson(rolJson))
          .toList();
    } else {
      throw Exception('Error al obtener roles: ${response.data['detail']}');
    }
  }
}
