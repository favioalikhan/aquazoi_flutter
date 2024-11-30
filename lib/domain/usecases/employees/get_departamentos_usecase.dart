// lib/domain/usecases/employees/get_departamentos_usecase.dart
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/models/departamento_model.dart';
import '../../repositories/employee/departamento_repository.dart';

class GetDepartamentosUseCase extends UseCase<List<DepartamentoModel>, void> {
  final DepartamentoRepository repository;

  GetDepartamentosUseCase(this.repository);

  @override
  Future<Stream<List<DepartamentoModel>>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<List<DepartamentoModel>>();
    try {
      final departamentos = await repository.getDepartamentos();
      controller.add(departamentos);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
