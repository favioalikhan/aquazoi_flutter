import 'package:intl/intl.dart';

import '../entity/empleado.dart';
import 'departamento_model.dart';
import 'rol_model.dart';

class EmpleadoModel extends Empleado {
  EmpleadoModel({
    required super.email,
    required super.nombre,
    required super.apellidoPaterno,
    required super.apellidoMaterno,
    required super.dni,
    super.telefono,
    super.direccion,
    required super.fechaContratacion,
    required super.fechaIngreso,
    required super.fechaBaja,
    required super.puesto,
    required super.estado,
    required super.departamentoPrincipal,
    required super.rolPrincipal,
    super.roles,
    required super.accesoSistema,
  });

  // Convertir desde JSON
  factory EmpleadoModel.fromJson(Map<String, dynamic> json) {
    return EmpleadoModel(
      email: json['email'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      dni: json['dni'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      fechaContratacion:
          DateFormat('yyyy-MM-dd').parseStrict(json['fecha_contratacion']),
      fechaIngreso: DateFormat('yyyy-MM-dd').parseStrict(json['fecha_ingreso']),
      fechaBaja: DateFormat('yyyy-MM-dd').parseStrict(json['fecha_baja']),
      puesto: json['puesto'],
      estado: json['estado'],
      departamentoPrincipal: json['departamento_principal'] != null
          ? DepartamentoModel.fromJson(json['departamento_principal'])
          : null,
      rolPrincipal: json['rol_principal'] != null
          ? RolModel.fromJson(json['rol_principal'])
          : null,
      accesoSistema: json['acceso_sistema'],
      roles: (json['roles'] as List)
          .map((rolJson) => RolModel.fromJson(rolJson))
          .toList(),
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'email': email,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'dni': dni,
      'telefono': telefono,
      'direccion': direccion,
      'fecha_contratacion': dateFormat.format(
          fechaContratacion), // Usamos la instancia para formatear la fecha
      'fecha_ingreso': dateFormat
          .format(fechaIngreso), // Usamos la instancia para formatear la fecha
      'fecha_baja': dateFormat
          .format(fechaBaja), // Usamos la instancia para formatear la fecha
      'puesto': puesto,
      'estado': estado,
      'departamento_principal': departamentoPrincipal?.id,
      'rol_principal': rolPrincipal?.id,
      'acceso_sistema': accesoSistema,
      'roles': roles?.map((rol) => (rol as RolModel).toJson()).toList(),
    };
  }
}
