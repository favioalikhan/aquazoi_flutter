import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/data_model/empleado_model.dart';
import '../../../usecases/empleado/empleado_usecase.dart';

// Eventos
abstract class EmpleadoEvent {}

class FetchEmpleadosEvent extends EmpleadoEvent {}

class AddEmpleadoEvent extends EmpleadoEvent {
  final EmpleadoModel empleado;

  AddEmpleadoEvent(this.empleado);
}

class UpdateEmpleadoEvent extends EmpleadoEvent {
  final EmpleadoModel empleado;

  UpdateEmpleadoEvent(this.empleado);
}

class DeleteEmpleadoEvent extends EmpleadoEvent {
  final EmpleadoModel empleado;

  DeleteEmpleadoEvent(this.empleado);
}

// Estados
abstract class EmpleadoState {}

class EmpleadoInitial extends EmpleadoState {}

class EmpleadoLoading extends EmpleadoState {}

class EmpleadosLoadedState extends EmpleadoState {
  final List<EmpleadoModel> empleados;

  EmpleadosLoadedState(this.empleados);
}

class EmpleadoOperationSuccess extends EmpleadoState {
  final EmpleadoModel empleado;

  EmpleadoOperationSuccess(this.empleado);
}

class EmpleadoFailure extends EmpleadoState {
  final String error;

  EmpleadoFailure(this.error);
}

// Bloc
class EmpleadoBloc extends Bloc<EmpleadoEvent, EmpleadoState> {
  final EmpleadoUseCase empleadoUseCase;

  EmpleadoBloc(this.empleadoUseCase) : super(EmpleadoInitial()) {
    on<FetchEmpleadosEvent>((event, emit) async {
      emit(EmpleadoLoading());
      try {
        final empleados = await empleadoUseCase.getEmpleados();
        emit(EmpleadosLoadedState(empleados));
      } catch (e) {
        emit(EmpleadoFailure(e.toString()));
      }
    });

    on<AddEmpleadoEvent>((event, emit) async {
      emit(EmpleadoLoading());
      try {
        final empleadoCreado =
            await empleadoUseCase.addEmpleado(event.empleado);
        emit(EmpleadoOperationSuccess(empleadoCreado));
      } catch (e) {
        emit(EmpleadoFailure(e.toString()));
      }
    });

    on<UpdateEmpleadoEvent>((event, emit) async {
      emit(EmpleadoLoading());
      try {
        final empleadoActualizado =
            await empleadoUseCase.updateEmpleado(event.empleado);
        emit(EmpleadoOperationSuccess(empleadoActualizado));
      } catch (e) {
        emit(EmpleadoFailure(e.toString()));
      }
    });

    on<DeleteEmpleadoEvent>((event, emit) async {
      emit(EmpleadoLoading());
      try {
        await empleadoUseCase.deleteEmpleado(event.empleado);
        emit(EmpleadoOperationSuccess(event.empleado));
      } catch (e) {
        emit(EmpleadoFailure(e.toString()));
      }
    });
  }
}
