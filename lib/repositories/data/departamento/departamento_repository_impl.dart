import '../../../models/data_model/departamento_model.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/endpoints.dart';
import 'departamento_repository.dart';

class DepartamentoRepositoryImpl implements DepartamentoRepository {
  final ApiClient apiClient;

  DepartamentoRepositoryImpl(this.apiClient);

  @override
  Future<List<DepartamentoModel>> getDepartamentos() async {
    final response = await apiClient.get(ApiEndpoints.departamentos);

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((departamentoJson) =>
              DepartamentoModel.fromJson(departamentoJson))
          .toList();
    } else {
      throw Exception(
          'Error al obtener departamentos: ${response.data['detail']}');
    }
  }
}
