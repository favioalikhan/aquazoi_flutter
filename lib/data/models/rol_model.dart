import 'package:flutter/widgets.dart';

class RolDetailModel {
  final int id;
  final String nombre;
  final bool esPrincipal;

  RolDetailModel({
    required this.id,
    required this.nombre,
    required this.esPrincipal,
  });

  factory RolDetailModel.fromJson(Map<String, dynamic> json) {
    return RolDetailModel(
      id: json['id'],
      nombre: json['nombre'],
      esPrincipal: json['es_principal'] ?? TraversalRequestFocusCallback,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
    };
  }
}
