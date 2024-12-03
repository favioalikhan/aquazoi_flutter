import 'package:logger/logger.dart';

import '../../models/data_model/empleado_model.dart';
import '../../repositories/data/empleado/empleado_repository.dart';

final Logger logger = Logger();

class EmpleadoUseCase {
  final EmpleadoRepository repository;

  EmpleadoUseCase(this.repository);

  Future<List<EmpleadoModel>> getEmpleados() async {
    return repository.getEmpleados();
  }

  Future<EmpleadoModel> addEmpleado(EmpleadoModel empleado) {
    return repository.addEmpleado(empleado);
  }

  Future<EmpleadoModel> updateEmpleado(int id, EmpleadoModel empleado) async {
    try {
      logger.i('Intentando actualizar empleado: ${empleado.id}');

      final empleadoActualizado = await repository.updateEmpleado(id, empleado);

      logger.i('Empleado actualizado exitosamente: ${empleado.id}');

      return empleadoActualizado;
    } catch (e) {
      logger.e('Error al actualizar empleado', error: e);
      rethrow;
    }
  }

  Future<void> deleteEmpleado(int id) {
    return repository.deleteEmpleado(id);
  }
  /*
  // Método de creación con validación y registro
  Future<EmpleadoModel> addEmpleado(EmpleadoModel empleado) async {
    try {
      // Validación previa a la creación

      logger.i('Intentando crear empleado: ${empleado.nombre}');

      final empleadoCreado = await repository.addEmpleado(empleado);

      logger.i('Empleado creado exitosamente: ${empleadoCreado.id}');

      return empleadoCreado;
    } on ValidationException catch (ve) {
      logger.w('Errores de validación al crear empleado', error: ve.errors);
      rethrow;
    } catch (e) {
      logger.e('Error al crear empleado', error: e);
      logger.i('Datos del empleado: ${empleado.toJson()}');
      logger.i('Rol Principal: ${empleado.rolPrincipal}');
      logger.i('Departamento Principal: ${empleado.departamentoPrincipal}');
      rethrow;
    }
  }

  // Método de actualización con validación y registro
  Future<EmpleadoModel> updateEmpleado(
      int empleadoId, EmpleadoModel empleado) async {
    try {
      // Validación previa a la actualización
      validarEmpleado(empleado);

      logger.i('Intentando actualizar empleado ID: $empleadoId');
      logger.i('Datos de actualización: ${empleado.nombre}');

      final empleadoActualizado =
          await repository.updateEmpleado(empleadoId, empleado);

      logger.i('Empleado actualizado exitosamente: $empleadoId');

      return empleadoActualizado;
    } on ValidationException catch (ve) {
      logger.w('Errores de validación al actualizar empleado',
          error: ve.errors);
      rethrow;
    } catch (e) {
      logger.e('Error al actualizar empleado', error: e);
      logger.i('Datos del empleado: ${empleado.toJson()}');
      logger.i('Rol Principal: ${empleado.rolPrincipal}');
      logger.i('Departamento Principal: ${empleado.departamentoPrincipal}');
      rethrow;
    }
  }

  // Método de eliminación con verificaciones adicionales
  Future<void> deleteEmpleado(EmpleadoModel empleado) async {
    try {
      // Ejemplo de validación antes de eliminar
      if (empleado.estado != 'INACTIVO') {
        throw ValidationException(
            ['Solo se pueden eliminar empleados inactivos']);
      }

      logger.i('Intentando eliminar empleado: ${empleado.id}');

      await repository.deleteEmpleado(empleado);

      logger.i('Empleado eliminado exitosamente: ${empleado.id}');
    } catch (e) {
      logger.e('Error al eliminar empleado', error: e);
      rethrow;
    }
  }

  // Métodos de búsqueda específicos
  Future<List<EmpleadoModel>> buscarPorNombre(String nombreBusqueda) async {
    try {
      final empleados = await repository.getEmpleados();
      return empleados
          .where((empleado) =>
              empleado.nombre!
                  .toLowerCase()
                  .contains(nombreBusqueda.toLowerCase()) ||
              empleado.apellidoPaterno!
                  .toLowerCase()
                  .contains(nombreBusqueda.toLowerCase()) ||
              empleado.apellidoMaterno!
                  .toLowerCase()
                  .contains(nombreBusqueda.toLowerCase()))
          .toList();
    } catch (e) {
      logger.e('Error al buscar empleados por nombre', error: e);
      rethrow;
    }
  }

  // Método de estadísticas de empleados
  Future<Map<String, dynamic>> getEstadisticasEmpleados() async {
    try {
      final empleados = await repository.getEmpleados();

      return {
        'totalEmpleados': empleados.length,
        'empleadosActivos': empleados.where((e) => e.estado == 'ACTIVO').length,
        'empleadosPorDepartamento': _agruparPorDepartamento(empleados),
        'empleadosPorRol': _agruparPorRol(empleados),
      };
    } catch (e) {
      logger.e('Error al generar estadísticas de empleados', error: e);
      rethrow;
    }
  }

  /*
  Future<List<Map<String, dynamic>>> getEmpleadosListado({
    String? departamentoId,
    String? rolId,
    String? estado,
  }) async {
    try {
      // Recuperar empleados con filtros opcionales
      final empleados = await getEmpleados(
        departamentoId: departamentoId,
        rolId: rolId,
        estado: estado,
      );

      // Transformar la lista de empleados al formato deseado
      return empleados
          .map((empleado) => {
                'nombre': empleado.nombre,
                'apellidoPaterno': empleado.apellidoPaterno,
                'dni': empleado.dni,
                'telefono': empleado.telefono ?? 'No registrado',
                'puesto': empleado.puesto,
                'departamentoPrincipal':
                    empleado.departamentoPrincipal?.nombre ??
                        'Sin departamento',
                'rolPrincipal':
                    empleado.rolPrincipal?.nombre ?? 'Sin rol principal',
              })
          .toList();
    } catch (e) {
      logger.e('Error al recuperar listado de empleados', error: e);
      rethrow;
    }
  }
   */
  // Método adicional para búsquedas específicas en el listado
  Future<List<Map<String, dynamic>>> buscarEmpleadosListado(
      String terminoBusqueda) async {
    try {
      final empleados = await buscarPorNombre(terminoBusqueda);

      return empleados
          .map((empleado) => {
                'nombre': empleado.nombre,
                'apellidoPaterno': empleado.apellidoPaterno,
                'dni': empleado.dni,
                'telefono': empleado.telefono ?? 'No registrado',
                'puesto': empleado.puesto,
                'departamentoPrincipal':
                    empleado.departamentoPrincipal?.nombre ??
                        'Sin departamento',
                'rolPrincipal':
                    empleado.rolPrincipal?.nombre ?? 'Sin rol principal',
              })
          .toList();
    } catch (e) {
      logger.e('Error al buscar empleados en listado', error: e);
      rethrow;
    }
  }

  // Método para obtener empleados paginados
  /*
  Future<Map<String, dynamic>> getEmpleadosPaginados({
    int pagina = 1,
    int elementosPorPagina = 10,
    String? departamentoId,
    String? rolId,
    String? estado,
  }) async {
    try {
      final empleados = await getEmpleados(
        departamentoId: departamentoId,
        rolId: rolId,
        estado: estado,
      );

      // Calcular índices de paginación
      final inicio = (pagina - 1) * elementosPorPagina;
      final fin = inicio + elementosPorPagina;

      final empleadosPaginados = empleados
          .skip(inicio)
          .take(elementosPorPagina)
          .map((empleado) => {
                'nombre': empleado.nombre,
                'apellidoPaterno': empleado.apellidoPaterno,
                'dni': empleado.dni,
                'telefono': empleado.telefono ?? 'No registrado',
                'puesto': empleado.puesto,
                'departamentoPrincipal':
                    empleado.departamentoPrincipal?.nombre ??
                        'Sin departamento',
                'rolPrincipal':
                    empleado.rolPrincipal?.nombre ?? 'Sin rol principal',
              })
          .toList();

      return {
        'empleados': empleadosPaginados,
        'totalEmpleados': empleados.length,
        'paginaActual': pagina,
        'totalPaginas': (empleados.length / elementosPorPagina).ceil(),
      };
    } catch (e) {
      logger.e('Error al recuperar empleados paginados', e);
      rethrow;
    }
  }*/
  // Optional: Additional business logic methods
/*Future<List<EmpleadoModel>> getEmpleadosByDepartamento(
      String departamentoId) async {
    return await repository.getEmpleadosByDepartamento(departamentoId);
  }

  Future<List<EmpleadoModel>> getEmpleadosByRol(String rolId) async {
    return await repository.getEmpleadosByRol(rolId);
  }*/

  // Métodos auxiliares para agrupación
  Map<String, int> _agruparPorDepartamento(List<EmpleadoModel> empleados) {
    final grupos = <String, int>{};
    for (var empleado in empleados) {
      final departamento =
          empleado.departamentoPrincipal?.nombre ?? 'Sin Departamento';
      grupos[departamento] = (grupos[departamento] ?? 0) + 1;
    }
    return grupos;
  }

  Map<String, int> _agruparPorRol(List<EmpleadoModel> empleados) {
    final grupos = <String, int>{};
    for (var empleado in empleados) {
      for (var rol in empleado.roles ?? []) {
        grupos[rol.nombre ?? 'Sin Rol'] = (grupos[rol.nombre] ?? 0) + 1;
      }
    }
    return grupos;
  }
}

// Clase de excepción personalizada para validaciones
class ValidationException implements Exception {
  final List<String> errors;

  ValidationException(this.errors);

  @override
  String toString() {
    return 'Errores de validación: ${errors.join(', ')}';
  }
  */
}
