// empleado_event.dart

import 'package:equatable/equatable.dart';

import '../../../models/data_model/empleado_model.dart';

/// Clase base para todos los eventos relacionados con los empleados.
abstract class EmpleadoEvent extends Equatable {
  const EmpleadoEvent();

  @override
  List<Object> get props => [];
}

/// Evento para obtener la lista de empleados.
class FetchEmpleadosEvent extends EmpleadoEvent {}

/// Evento para agregar un nuevo empleado.
class AddEmpleadoEvent extends EmpleadoEvent {
  final EmpleadoModel empleado;

  const AddEmpleadoEvent(this.empleado);

  @override
  List<Object> get props => [empleado];
}

/// Evento para actualizar un empleado existente.
class UpdateEmpleadoEvent extends EmpleadoEvent {
  final int empleadoId;
  final EmpleadoModel empleado;

  const UpdateEmpleadoEvent(this.empleadoId, this.empleado);

  @override
  List<Object> get props => [empleadoId];
}

/// Evento para eliminar un empleado.
class DeleteEmpleadoEvent extends EmpleadoEvent {
  final int empleadoId;

  const DeleteEmpleadoEvent(this.empleadoId);

  @override
  List<Object> get props => [empleadoId];
}
