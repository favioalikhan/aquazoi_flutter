import '../../../models/data_model/empleado_model.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/endpoints.dart';
import 'empleado_repository.dart';

class EmpleadoRepositoryImpl implements EmpleadoRepository {
  final ApiClient apiClient;

  EmpleadoRepositoryImpl(this.apiClient);

  @override
  Future<List<EmpleadoModel>> getEmpleados() async {
    final response = await apiClient.get(ApiEndpoints.empleados);

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((empleadoJson) => EmpleadoModel.fromJson(empleadoJson))
          .toList();
    } else {
      throw Exception('Error al obtener empleados: ${response.data['detail']}');
    }
  }

  @override
  Future<EmpleadoModel> addEmpleado(EmpleadoModel empleado) async {
    final response =
        await apiClient.post(ApiEndpoints.registroEmpleado, empleado.toJson());

    if (response.statusCode == 201) {
      return EmpleadoModel.fromJson(response.data);
    } else {
      throw Exception('Error al crear empleado: ${response.data['detail']}');
    }
  }

  @override
  Future<EmpleadoModel> updateEmpleado(
      int empleadoId, EmpleadoModel empleado) async {
    final empleadoJson = empleado.toJson();
    final response = await apiClient.put(
      ApiEndpoints.updateEmpleado(empleadoId),
      empleadoJson,
    );

    if (response.statusCode == 200) {
      return EmpleadoModel.fromJson(response.data);
    } else {
      throw Exception('Error al actualizar empleado: ${response.statusCode}');
    }
  }

  @override
  Future<EmpleadoModel> deleteEmpleado(int empleadoId) async {
    final response = await apiClient.delete(
      ApiEndpoints.deleteEmpleado(empleadoId), // Usando el endpoint correcto
    );

    if (response.statusCode == 200) {
      return EmpleadoModel.fromJson(response.data);
    } else {
      throw Exception('Error al eliminar empleado: ${response.data['detail']}');
    }
  }
}
