class Empleado {
  final int? id;
  final String? email;
  final String? nombre;
  final String? apellidoPaterno;
  final String? apellidoMaterno;
  final String dni;
  final String? telefono;
  final String? direccion;
  final DateTime? fechaContratacion;
  final DateTime? fechaIngreso;
  final DateTime? fechaBaja;
  final String puesto;
  final String? estado;
  final int? departamentoPrincipal;
  final bool accesoSistema;
  final int? rolPrincipal; // Rol principal
  final List<int>? roles; // Lista de roles

  Empleado({
    this.id,
    this.email,
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    required this.dni,
    this.telefono,
    this.direccion,
    this.fechaContratacion,
    this.fechaIngreso,
    this.fechaBaja,
    required this.puesto,
    this.estado,
    this.departamentoPrincipal,
    required this.accesoSistema,
    this.rolPrincipal,
    this.roles,
  });
}
