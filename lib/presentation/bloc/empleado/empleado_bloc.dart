// empleado_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/data_model/empleado_model.dart';
import '../../../usecases/empleado/empleado_usecase.dart';
import 'empleado_event.dart';
import 'empleado_state.dart';

class EmpleadoBloc extends Bloc<EmpleadoEvent, EmpleadoState> {
  final EmpleadoUseCase empleadoUseCase;
  List<EmpleadoModel> _empleados = []; // Lista interna de empleados

  EmpleadoBloc(this.empleadoUseCase) : super(EmpleadoInitial()) {
    on<FetchEmpleadosEvent>(_onFetchEmpleados);
    on<AddEmpleadoEvent>(_onAddEmpleado);
    on<UpdateEmpleadoEvent>(_onUpdateEmpleado);
    on<DeleteEmpleadoEvent>(_onDeleteEmpleado);
  }

  Future<void> _onFetchEmpleados(
      FetchEmpleadosEvent event, Emitter<EmpleadoState> emit) async {
    emit(EmpleadoLoading());
    try {
      _empleados = await empleadoUseCase.getEmpleados();
      emit(EmpleadosLoadedState(List.from(_empleados)));
    } catch (e) {
      emit(EmpleadoFailure(e.toString()));
    }
  }

  Future<void> _onAddEmpleado(
      AddEmpleadoEvent event, Emitter<EmpleadoState> emit) async {
    emit(EmpleadoLoading());
    try {
      final empleadoCreado = await empleadoUseCase.addEmpleado(event.empleado);
      _empleados.add(empleadoCreado);
      emit(EmpleadosLoadedState(List.from(_empleados)));
    } catch (e) {
      emit(EmpleadoFailure(e.toString()));
    }
  }

  Future<void> _onUpdateEmpleado(
      UpdateEmpleadoEvent event, Emitter<EmpleadoState> emit) async {
    emit(EmpleadoLoading());
    try {
      final empleadoActualizado = await empleadoUseCase.updateEmpleado(
          event.empleadoId, event.empleado);

      final index = _empleados.indexWhere((emp) => emp.id == event.empleadoId);
      if (index != -1) {
        _empleados[index] = empleadoActualizado;
        emit(EmpleadosLoadedState(List.from(_empleados)));
      } else {
        emit(EmpleadoFailure('Empleado no encontrado'));
      }
    } catch (e) {
      emit(EmpleadoFailure(e.toString()));
    }
  }

  Future<void> _onDeleteEmpleado(
      DeleteEmpleadoEvent event, Emitter<EmpleadoState> emit) async {
    emit(EmpleadoLoading());
    try {
      await empleadoUseCase.deleteEmpleado(event.empleadoId);
      _empleados.removeWhere((emp) => emp.id == event.empleadoId);
      emit(EmpleadosLoadedState(List.from(_empleados)));
    } catch (e) {
      emit(EmpleadoFailure(e.toString()));
    }
  }
}
