class Departamento {
  final int id;
  final String nombre;
  final String? descripcion;

  Departamento({
    required this.id,
    required this.nombre,
    this.descripcion,
  });
}