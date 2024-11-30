import '../../../data/models/rol_model.dart';

abstract class RolRepository {
  Future<List<RolDetailModel>> getRolesByDepartamento(int departamentoId);
}
