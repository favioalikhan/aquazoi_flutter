import 'package:aquazoi/models/data_model/empleado_model.dart';

abstract class EmpleadoRepository {
  Future<List<EmpleadoModel>> getEmpleados();
  Future<EmpleadoModel> addEmpleado(EmpleadoModel empleado);
  Future<EmpleadoModel> updateEmpleado(EmpleadoModel empleado);
  Future<EmpleadoModel> deleteEmpleado(EmpleadoModel empleado);
}
