// lib/app/configuration/employees/employees_presenter.dart
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../../domain/entities/employee.dart';
import '../../../../domain/usecases/employees/get_employees_usecase.dart';

class EmpleadosPresenter extends Presenter {
  late Function(List<Empleado>) getEmpleadosOnNext;
  late Function(dynamic error) getEmpleadosOnError;
  late Function() getEmpleadosOnComplete;

  final GetEmpleadosUseCase _getEmpleadosUseCase;

  EmpleadosPresenter(this._getEmpleadosUseCase);

  void getEmpleados({int? page, int? limit, String? filter}) {
    print('Presenter: Iniciando obtención de empleados');
    _getEmpleadosUseCase.execute(
      _GetEmpleadosObserver(this),
      GetEmpleadosParams(page: page, limit: limit, filter: filter),
    );
  }

  @override
  void dispose() {
    _getEmpleadosUseCase.dispose();
  }
}

class _GetEmpleadosObserver implements Observer<List<Empleado>?> {
  final EmpleadosPresenter presenter;

  _GetEmpleadosObserver(this.presenter);

  @override
  void onNext(List<Empleado>? empleados) {
    if (empleados != null) {
      presenter.getEmpleadosOnNext(empleados);
    } else {
      presenter.getEmpleadosOnError(
          Exception('No se recibieron datos de empleados'));
    }
  }

  @override
  void onComplete() {
    // Aquí puedes manejar la finalización, si es necesario
    print('Observer: Completado');
    presenter.getEmpleadosOnComplete();
  }

  @override
  void onError(e) {
    // Manejar los errores
    print('Observer: Error - $e');
    presenter.getEmpleadosOnError(e);
  }
}
