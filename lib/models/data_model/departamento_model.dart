import '../entity/departamento.dart';

class DepartamentoModel extends Departamento {
  DepartamentoModel({
    required super.id,
    required super.nombre,
    super.descripcion,
  });

  // Convertir desde JSON
  factory DepartamentoModel.fromJson(Map<String, dynamic> json) {
    return DepartamentoModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
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
