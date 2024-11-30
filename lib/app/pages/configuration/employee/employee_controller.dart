// lib/app/configuration/employees/employees_controller.dart
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entities/employee.dart';
import 'employee_presenter.dart';

class EmpleadosController extends Controller {
  final EmpleadosPresenter presenter;
  List<Empleado> empleados = [];
  bool isLoading = false;
  String? errorMessage;

  EmpleadosController(this.presenter);

  @override
  void onInitState() {
    initListeners();
    super.onInitState();
    initListeners();
    fetchEmpleados();
  }

  @override
  void initListeners() {
    presenter.getEmpleadosOnNext = (List<Empleado> empleadosList) {
      print('Controller: Recibidos ${empleadosList.length} empleados');
      empleados = empleadosList;
      isLoading = false;
      refreshUI();
    };

    presenter.getEmpleadosOnComplete = () {
      print('Controller: Operación completada');
      if (isLoading) {
        isLoading = false;
        refreshUI();
      }
    };

    presenter.getEmpleadosOnError = (dynamic error) {
      print('Controller: Error - $error');
      errorMessage = error.toString();
      isLoading = false;
      refreshUI();
    };
  }

  void fetchEmpleados({int? page, int? limit, String? filter}) {
    print('Controller: Iniciando fetch de empleados');
    isLoading = true;
    errorMessage = null;
    refreshUI();

    try {
      presenter.getEmpleados(
        page: page,
        limit: limit,
        filter: filter,
      );
    } catch (e) {
      print('Controller: Error en fetch - $e');
      errorMessage = e.toString();
      isLoading = false;
      refreshUI();
    }
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
