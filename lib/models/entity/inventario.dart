import 'producto.dart';
import 'produccion.dart';

class Inventario {
  final int? id;
  final Producto? producto;
  final String numeroLote;
  final int cantidadActual;
  final int? puntoReorden;
  final int? stockMinimo;
  final DateTime fechaVencimiento;
  final Produccion? controlProduccion;
  final DateTime fechaActualizacion;

  Inventario({
    this.id,
    required this.producto,
    required this.numeroLote,
    required this.cantidadActual,
    this.puntoReorden,
    this.stockMinimo,
    required this.fechaVencimiento,
    this.controlProduccion,
    required this.fechaActualizacion,
  });
}
