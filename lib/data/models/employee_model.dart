// lib/data/models/employee_model.dart
import 'package:aquazoi/data/models/rol_model.dart';

import '../../domain/entities/employee.dart';

class EmpleadoModel extends Empleado {
  EmpleadoModel({
    required super.id,
    required super.nombre,
    required super.apellidoPaterno,
    required super.apellidoMaterno,
    required super.email,
    required super.dni,
    super.telefono,
    super.puesto,
    required super.departamentoPrincipal,
    required super.roles,
    required super.accesoSistema,
  });

  /// Método para crear un `EmpleadoModel` desde un mapa JSON
  factory EmpleadoModel.fromJson(Map<String, dynamic> json) {
    return EmpleadoModel(
      id: json['id'] as int,
      nombre: json['nombre'] ?? '',
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      email: json['email'] ?? '',
      dni: json['dni'] ?? '',
      telefono: json['telefono'] ?? '',
      puesto: json['puesto'] ?? '',
      departamentoPrincipal: json['departamento_principal'] is Map
          ? (json['departamento_principal']['nombre'] ?? '')
          : (json['departamento_principal'] ?? ''),
      roles: (json['roles'] as List<dynamic>)
          .map((rol) => RolDetailModel.fromJson(rol).nombre)
          .toList(),
      accesoSistema: json['acceso_sistema'] as bool? ?? false,
    );
  }

  /// Método para convertir un EmpleadoModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'email': email,
      'dni': dni,
      'telefono': telefono,
      'puesto': puesto,
      'departamento_principal': {'nombre': departamentoPrincipal},
      'roles': roles.map((nombre) => {'nombre': nombre}).toList(),
      'acceso_sistema': accesoSistema,
    };
  }

  EmpleadoModel copyWith({
    int? id,
    String? nombre,
    String? apellidoPaterno,
    String? apellidoMaterno,
    String? email,
    String? dni,
    String? telefono,
    String? puesto,
    String? departamentoPrincipal,
    List<String>? roles,
    bool? accesoSistema,
  }) {
    return EmpleadoModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
      apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
      email: email ?? this.email,
      dni: dni ?? this.dni,
      telefono: telefono ?? this.telefono,
      puesto: puesto ?? this.puesto,
      departamentoPrincipal:
          departamentoPrincipal ?? this.departamentoPrincipal,
      roles: roles ?? this.roles,
      accesoSistema: accesoSistema ?? this.accesoSistema,
    );
  }
}
