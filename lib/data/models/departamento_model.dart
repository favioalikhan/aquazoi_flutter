// lib/data/models/departamento_model.dart
class DepartamentoModel {
  final int id;
  final String nombre;

  DepartamentoModel({
    required this.id,
    required this.nombre,
  });

  factory DepartamentoModel.fromJson(Map<String, dynamic> json) {
    return DepartamentoModel(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
