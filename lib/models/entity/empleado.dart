import 'departamento.dart';
import 'rol.dart';

class Empleado {
  final int? id;
  final String email;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String dni;
  final String? telefono;
  final String? direccion;
  final DateTime fechaContratacion;
  final DateTime fechaIngreso;
  final DateTime fechaBaja;
  final String puesto;
  final String estado;
  final Departamento? departamentoPrincipal;
  final bool accesoSistema;
  final Rol? rolPrincipal; // Rol principal
  final List<Rol>? roles; // Lista de roles

  Empleado({
    this.id,
    required this.email,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.dni,
    this.telefono,
    this.direccion,
    required this.fechaContratacion,
    required this.fechaIngreso,
    required this.fechaBaja,
    required this.puesto,
    required this.estado,
    required this.departamentoPrincipal,
    required this.accesoSistema,
    required this.rolPrincipal,
    this.roles,
  });
}
