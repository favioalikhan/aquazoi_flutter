import '../../../models/data_model/rol_model.dart';

abstract class RolRepository {
  Future<List<RolModel>> getRoles(int departamentoId);
}
