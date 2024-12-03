import 'package:intl/intl.dart';

import '../entity/empleado.dart';

class EmpleadoModel extends Empleado {
  EmpleadoModel({
    super.id,
    super.email,
    super.nombre,
    super.apellidoPaterno,
    super.apellidoMaterno,
    required super.dni,
    super.telefono,
    super.direccion,
    super.fechaContratacion,
    super.fechaIngreso,
    super.fechaBaja,
    required super.puesto,
    super.estado,
    super.departamentoPrincipal,
    super.rolPrincipal,
    super.roles,
    required super.accesoSistema,
  });

  // Convertir desde JSON
  factory EmpleadoModel.fromJson(Map<String, dynamic> json) {
    return EmpleadoModel(
      id: json['id'],
      email: json['email'] as String?,
      nombre: json['nombre'] as String?,
      apellidoPaterno: json['apellido_paterno'] as String?,
      apellidoMaterno: json['apellido_materno'] as String?,
      dni: json['dni'] as String,
      telefono: json['telefono'] as String?,
      direccion: json['direccion'] as String?,
      fechaContratacion: json['fecha_contratacion'] != null
          ? DateTime.parse(json['fecha_contratacion'] as String)
          : null,
      fechaIngreso: json['fecha_ingreso'] != null
          ? DateTime.parse(json['fecha_ingreso'] as String)
          : null,
      fechaBaja: json['fecha_baja'] != null
          ? DateTime.parse(json['fecha_baja'] as String)
          : null,
      puesto: json['puesto'] as String,
      estado: json['estado'] as String?,
      departamentoPrincipal: json['departamento_principal'] != null
          ? json['departamento_principal']['id'] as int
          : null,
      accesoSistema: json['acceso_sistema'] as bool? ?? false,
      rolPrincipal: json['rol_principal'] != null
          ? json['rol_principal']['id'] as int
          : null,
      roles: json['roles'] != null
          ? List<int>.from(
              (json['roles'] as List).map((role) => role['id'] as int))
          : null,
    );
  }

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
      'fecha_contratacion': fechaContratacion != null
          ? dateFormat.format(fechaContratacion!)
          : null, // Usamos la instancia para formatear la fecha
      'fecha_ingreso': fechaIngreso != null
          ? dateFormat.format(fechaIngreso!)
          : null, // Usamos la instancia para formatear la fecha
      'fecha_baja': fechaBaja != null
          ? dateFormat.format(fechaBaja!)
          : null, // Usamos la instancia para formatear la fecha
      'puesto': puesto,
      'estado': estado,
      'departamento_principal': departamentoPrincipal,
      'rol_principal': rolPrincipal,
      'acceso_sistema': accesoSistema,
      'roles': roles,
    };
  }
}
