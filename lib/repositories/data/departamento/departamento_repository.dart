import '../../../models/data_model/departamento_model.dart';

abstract class DepartamentoRepository {
  Future<List<DepartamentoModel>> getDepartamentos();
}
