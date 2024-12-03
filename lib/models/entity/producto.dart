import 'dart:ffi';

class Producto {
  final int? id;
  final String nombre;
  final String? descripcion;
  final double precioUnitario;
  final String unidadMedida;
  final bool? estado;

  Producto({
    this.id,
    required this.nombre,
    this.descripcion,
    required this.precioUnitario,
    required this.unidadMedida,
    this.estado,
  });
}
