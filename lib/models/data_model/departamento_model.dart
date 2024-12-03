import '../entity/departamento.dart';

class DepartamentoModel extends Departamento {
  DepartamentoModel({
    required super.id,
    super.nombre,
    super.descripcion,
  });

  // Convertir desde JSON
  factory DepartamentoModel.fromJson(Map<String, dynamic> json) {
    return DepartamentoModel(
      id: json['id'] as int,
      nombre: json['nombre'] as String?,
      descripcion: json['descripcion'] as String?,
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
