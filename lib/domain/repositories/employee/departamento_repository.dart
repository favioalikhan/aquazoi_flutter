import '../../../data/models/departamento_model.dart';

abstract class DepartamentoRepository {
  Future<List<DepartamentoModel>> getDepartamentos();
}
