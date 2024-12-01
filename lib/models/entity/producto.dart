class Producto {
  final int? id;
  final String nombre;
  final String? descripcion;
  final int precioUnitario;
  final int unidadMedida;
  final int? estado;

  Producto({
    this.id,
    required this.nombre,
    this.descripcion,
    required this.precioUnitario,
    required this.unidadMedida,
    this.estado,
  });
}
