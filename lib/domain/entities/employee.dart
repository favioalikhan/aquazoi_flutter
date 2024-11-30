// lib/domain/entities/employee.dart

class Empleado {
  final int id;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String email;
  final String dni;
  final String? telefono;
  final String? puesto;
  final String departamentoPrincipal; // Solo el nombre del departamento
  final List<String> roles; // Lista de nombres de roles
  final bool accesoSistema;

  Empleado({
    required this.id,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.email,
    required this.dni,
    this.telefono,
    required this.puesto,
    required this.departamentoPrincipal,
    required this.roles,
    required this.accesoSistema,
  });

  @override
  String toString() {
    return 'Empleado: $nombre $apellidoPaterno, Departamento: $departamentoPrincipal, Roles: $roles';
  }
}
