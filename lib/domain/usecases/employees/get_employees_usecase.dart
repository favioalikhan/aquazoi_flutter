// lib/domain/usecases/get_employees_usecase.dart
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/employee.dart';
import '../../repositories/employee/employee_repository.dart';

// Clase para los parámetros del caso de uso
class GetEmpleadosParams {
  final int? page;
  final int? limit;
  final String? filter;

  GetEmpleadosParams({
    this.page,
    this.limit,
    this.filter,
  });
}

class GetEmpleadosUseCase extends UseCase<List<Empleado>?, GetEmpleadosParams> {
  final EmpleadoRepository repository;

  GetEmpleadosUseCase(this.repository);

  @override
  Future<Stream<List<Empleado>?>> buildUseCaseStream(
      GetEmpleadosParams? params) async {
    final controller = StreamController<List<Empleado>>();
    try {
      print('UseCase: Iniciando obtención de empleados');
      final empleados = await repository.getEmpleados(
        page: params?.page,
        limit: params?.limit,
        filter: params?.filter,
      );
      print('UseCase: Empleados obtenidos: ${empleados.length}');
      controller.add(empleados);
    } catch (e) {
      print('UseCase: Error - $e');
      controller.addError(e);
    } finally {
      await controller.close();
    }
    return controller.stream;
  }
}
