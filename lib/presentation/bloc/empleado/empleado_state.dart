// empleado_state.dart

import 'package:equatable/equatable.dart';

import '../../../models/data_model/empleado_model.dart';

abstract class EmpleadoState extends Equatable {
  const EmpleadoState();

  @override
  List<Object> get props => [];
}

class EmpleadoInitial extends EmpleadoState {}

class EmpleadoLoading extends EmpleadoState {}

class EmpleadosLoadedState extends EmpleadoState {
  final List<EmpleadoModel> empleados;

  const EmpleadosLoadedState(this.empleados);

  @override
  List<Object> get props => [empleados];
}

class EmpleadoFailure extends EmpleadoState {
  final String error;

  const EmpleadoFailure(this.error);

  @override
  List<Object> get props => [error];
}
