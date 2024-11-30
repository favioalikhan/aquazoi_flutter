//add_employee_usecase.dart
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../entities/employee.dart';
import '../../repositories/employee/employee_repository.dart';

class AddEmpleadoUseCase extends UseCase<void, Empleado> {
  final EmpleadoRepository repository;

  AddEmpleadoUseCase(this.repository);

  @override
  Future<Stream<void>> buildUseCaseStream(Empleado? params) async {
    final controller = StreamController<void>();
    try {
      repository;
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
