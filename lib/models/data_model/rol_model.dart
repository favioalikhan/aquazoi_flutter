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
      id: json['id'],
      nombre: json['nombre'],
      responsabilidades: json['responsabilidades'],
      departamentoId: json['departamento_id'],
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
