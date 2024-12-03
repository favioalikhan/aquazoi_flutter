import '../entity/rol.dart';

class RolModel extends Rol {
  RolModel({
    super.id,
    super.nombre,
    super.responsabilidades,
    super.departamentoId,
    super.requiereAccesoSistema,
  });

  // Convertir desde JSON a RolModel
  factory RolModel.fromJson(Map<String, dynamic> json) {
    return RolModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
      responsabilidades: json['responsabilidades'] as String,
      departamentoId: json['departamento_id'] as int,
      requiereAccesoSistema: json['requiere_acceso_sistema'] ?? false,
    );
  }

  // Convertir de RolModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'responsabilidades': responsabilidades,
      'departamento_id': departamentoId,
      'requiere_acceso_sistema': requiereAccesoSistema,
    };
  }
}
