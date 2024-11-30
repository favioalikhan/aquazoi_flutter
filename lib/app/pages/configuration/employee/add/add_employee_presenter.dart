// lib/app/modules/configuration/employees/add_employee_presenter.dart
import 'package:aquazoi/domain/usecases/employees/get_departamentos_usecase.dart';
import 'package:aquazoi/domain/usecases/employees/get_roles_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/models/departamento_model.dart';
import '../../../../../data/models/rol_model.dart';
import '../../../../../domain/entities/employee.dart';
import '../../../../../domain/usecases/employees/add_employee_usecase.dart';

class AddEmpleadoPresenter extends Presenter {
  late Function onAddEmployeeComplete;
  late Function onAddEmployeeError;

  // Callbacks para obtener roles
  late Function getRolesOnNext;
  late Function getRolesOnComplete;
  late Function getRolesOnError;

  // Callbacks para obtener departamentos
  late Function getDepartamentosOnNext;
  late Function getDepartamentosOnComplete;
  late Function getDepartamentosOnError;

  final AddEmpleadoUseCase _addEmployeeUseCase;
  final GetDepartamentosUseCase _getDepartamentosUseCase;
  final GetRolesUseCase _getRolesUseCase;

  AddEmpleadoPresenter(
    AddEmpleadoUseCase addEmployeeUseCase,
    GetDepartamentosUseCase getDepartamentosUseCase,
    GetRolesUseCase getRolesUseCase,
  )   : _addEmployeeUseCase = addEmployeeUseCase,
        _getDepartamentosUseCase = getDepartamentosUseCase,
        _getRolesUseCase = getRolesUseCase;

  void addEmployee(Empleado empleado) {
    _addEmployeeUseCase.execute(_AddEmployeeObserver(this), empleado);
  }

  void getDepartamentos() {
    _getDepartamentosUseCase.execute(_GetDepartamentosObserver(this));
  }

  void getRoles(int departamentoId) {
    _getRolesUseCase.execute(
        _GetRolesObserver(this), GetRolesParams(departamentoId));
  }

  @override
  void dispose() {
    _addEmployeeUseCase.dispose();
    _getDepartamentosUseCase.dispose();
    _getRolesUseCase.dispose();
  }
}

class _AddEmployeeObserver extends Observer<void> {
  final AddEmpleadoPresenter presenter;

  _AddEmployeeObserver(this.presenter);

  @override
  void onComplete() {
    presenter.onAddEmployeeComplete();
  }

  @override
  void onError(e) {
    presenter.onAddEmployeeError(e);
  }

  @override
  void onNext(_) {}
}

class _GetDepartamentosObserver extends Observer<List<DepartamentoModel>> {
  final AddEmpleadoPresenter presenter;

  _GetDepartamentosObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getDepartamentosOnComplete();
  }

  @override
  void onError(e) {
    presenter.getDepartamentosOnError(e);
  }

  @override
  void onNext(List<DepartamentoModel>? response) {
    presenter.getDepartamentosOnNext(response);
  }
}

class _GetRolesObserver extends Observer<List<RolDetailModel>> {
  final AddEmpleadoPresenter presenter;

  _GetRolesObserver(this.presenter);

  @override
  void onComplete() {
    presenter.getRolesOnComplete();
  }

  @override
  void onError(e) {
    presenter.getRolesOnError(e);
  }

  @override
  void onNext(List<RolDetailModel>? response) {
    presenter.getRolesOnNext(response);
  }
}
