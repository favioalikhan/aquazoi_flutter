// lib/domain/usecases/employees/get_roles_usecase.dart
import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../data/models/rol_model.dart';
import '../../repositories/employee/rol_repository.dart';

class GetRolesParams {
  final int departamentoId;

  GetRolesParams(this.departamentoId);
}

class GetRolesUseCase extends UseCase<List<RolDetailModel>, GetRolesParams> {
  final RolRepository repository;

  GetRolesUseCase(this.repository);

  @override
  Future<Stream<List<RolDetailModel>>> buildUseCaseStream(
      GetRolesParams? params) async {
    final controller = StreamController<List<RolDetailModel>>();
    try {
      final roles =
          await repository.getRolesByDepartamento(params!.departamentoId);
      controller.add(roles);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}
