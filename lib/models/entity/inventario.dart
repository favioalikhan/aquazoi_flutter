import 'producto.dart';
import 'produccion.dart';

class Inventario {
  final int? id;
  final Producto? producto;
  final int cantidadActual;
  final int puntoReorden;
  final int stockMinimo;
  final int stockMaximo;
  final DateTime fechaVencimiento;
  final Produccion? controlProduccion;
  final DateTime fechaActualizacion;

  Inventario({
    this.id,
    required this.producto,
    required this.cantidadActual,
    required this.puntoReorden,
    required this.stockMinimo,
    required this.stockMaximo,
    required this.fechaVencimiento,
    this.controlProduccion,
    required this.fechaActualizacion,
  });
}
