// lib/app/modules/configuration/employees/add_employee_controller.dart
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../../data/models/departamento_model.dart';
import '../../../../../data/models/rol_model.dart';
import '../../../../../di/injection_container.dart';
import '../../../../../domain/entities/employee.dart';
import '../../../../../domain/usecases/employees/add_employee_usecase.dart';
import '../../../../../domain/usecases/employees/get_departamentos_usecase.dart';
import '../../../../../domain/usecases/employees/get_roles_usecase.dart';
import 'add_employee_presenter.dart';

class AddEmpleadoController extends Controller {
  // Variables para el formulario
  int? departamentoSeleccionado;
  RolDetailModel? rolPrincipalSeleccionado;
  bool accesoSistema = false;

  List<RolDetailModel> rolesDisponibles = [];
  List<DepartamentoModel> departamentos = [];
  bool isLoading = false;
  String? errorMessage;

  // Callbacks
  Function? onAddEmpleadoSuccess;
  Function? onAddEmpleadoError;

  final AddEmpleadoPresenter presenter;

  AddEmpleadoController()
      : presenter = AddEmpleadoPresenter(sl<AddEmpleadoUseCase>(),
            sl<GetDepartamentosUseCase>(), sl<GetRolesUseCase>()),
        super();

  @override
  void onInitState() {
    loadDepartamentos();
    super.onInitState();
  }

  @override
  void initListeners() {
    presenter.getDepartamentosOnNext =
        (List<DepartamentoModel> departamentoList) {
      departamentos = departamentoList;
      if (departamentos.isNotEmpty) {
        departamentoSeleccionado =
            departamentos.first.id; // Seleccionar el primero por defecto
        loadRoles(
            departamentoSeleccionado!); // Cargar roles para el primer departamento
      }
    };

    presenter.getDepartamentosOnComplete = () {
      isLoading = false;
      refreshUI();
    };

    presenter.getDepartamentosOnError = (e) {
      isLoading = false;
      errorMessage = e.toString();
      refreshUI();
    };

    presenter.getRolesOnNext = (List<RolDetailModel> rolesList) {
      rolesDisponibles = rolesList;
    };

    presenter.getRolesOnComplete = () {
      isLoading = false;
      refreshUI();
    };

    presenter.getRolesOnError = (e) {
      isLoading = false;
      errorMessage = e.toString();
      refreshUI();
    };
    // Listener para agregar empleado
    presenter.onAddEmployeeComplete = () {
      isLoading = false;
      if (onAddEmpleadoSuccess != null) {
        onAddEmpleadoSuccess!(); // Llamamos al callback de éxito
      }
      refreshUI();
    };

    presenter.onAddEmployeeError = (e) {
      errorMessage = e.toString();
      refreshUI();
      if (onAddEmpleadoSuccess != null) {
        onAddEmpleadoError!(e); // Llamamos al callback de error
      }
    };
  }

  void loadDepartamentos() {
    isLoading = true;
    refreshUI();
    presenter.getDepartamentos();
  }

  void loadRoles(int? departamentoId) {
    if (departamentoId == null) return; // Prevenir llamadas innecesarias
    isLoading = true;
    refreshUI();
    presenter.getRoles(departamentoId);
  }

  void addEmpleado(Empleado empleado) {
    isLoading = true;
    refreshUI();
    presenter.addEmployee(empleado);
  }

  void onDepartamentoChanged(int? value) {
    departamentoSeleccionado = value;
    rolPrincipalSeleccionado = null;
    if (value != null) {
      loadRoles(value);
    }
    refreshUI();
  }

  void onRolPrincipalChanged(RolDetailModel? value) {
    rolPrincipalSeleccionado = value;
    refreshUI();
  }

  void onAccesoSistemaChanged(bool value) {
    accesoSistema = value;
    refreshUI();
  }

  // Métodos para actualizar la UI desde los observadores
  void onGetDepartamentosComplete() {
    isLoading = false;
    refreshUI();
  }

  void onGetDepartamentosError(e) {
    isLoading = false;
    // Manejar el error si es necesario
    refreshUI();
  }

  void onGetDepartamentosNext(List<DepartamentoModel> departamentos) {
    this.departamentos = departamentos;
    refreshUI();
  }

  void onGetRolesComplete() {
    isLoading = false;
    refreshUI();
  }

  void onGetRolesError(e) {
    isLoading = false;
    // Manejar el error si es necesario
    refreshUI();
  }

  void onGetRolesNext(List<RolDetailModel> roles) {
    rolesDisponibles = roles;
    refreshUI();
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}

// Observadores para los casos de uso
class _GetDepartamentosObserver extends Observer<List<DepartamentoModel>> {
  final AddEmpleadoController _controller;

  _GetDepartamentosObserver(this._controller);

  @override
  void onComplete() {
    _controller.onGetDepartamentosComplete();
  }

  @override
  void onError(e) {
    _controller.onGetDepartamentosError(e);
  }

  @override
  void onNext(List<DepartamentoModel>? response) {
    _controller.onGetDepartamentosNext(response ?? []);
  }
}

class _GetRolesObserver extends Observer<List<RolDetailModel>> {
  final AddEmpleadoController _controller;

  _GetRolesObserver(this._controller);

  @override
  void onComplete() {
    _controller.onGetRolesComplete();
  }

  @override
  void onError(e) {
    _controller.onGetRolesError(e);
  }

  @override
  void onNext(List<RolDetailModel>? response) {
    _controller.onGetRolesNext(response ?? []);
  }
}
