import 'empleado.dart';

class Soplado {
  final int? id;
  final DateTime fecha;
  final String proveedorPreforma;
  final int pesoGramos;
  final int volumenBotellaMl;
  final int produccionBuena;
  final int produccionDanada;
  final int produccionTotal;
  final Empleado? empleado;
  final String? observaciones;

  Soplado({
    this.id,
    required this.fecha,
    required this.proveedorPreforma,
    required this.pesoGramos,
    required this.volumenBotellaMl,
    required this.produccionBuena,
    required this.produccionDanada,
    required this.produccionTotal,
    this.empleado,
    this.observaciones,
  });
}
