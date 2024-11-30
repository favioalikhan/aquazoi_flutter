// lib/domain/repositories/employee_repository.dart
import '../../entities/employee.dart';

abstract class EmpleadoRepository {
  /// Obtiene una lista de empleados.
  ///
  /// Puede lanzar excepciones relacionadas con la red o errores del servidor.
  Future<List<Empleado>> getEmpleados({int? page, int? limit, String? filter});
}
