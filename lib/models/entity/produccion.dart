import 'empleado.dart';

class Produccion {
  final int? id;
  final DateTime fechaProduccion;
  final String numeroLote;
  final DateTime fechaVencimiento;
  final int botellasEnvasadas;
  final int botellasMalogradas;
  final int tapasMalogradas;
  final int etiquetasMalogradas;
  final int totalBotellasBuenas;
  final int totalPaquetes;
  final Empleado? empleado;
  final String? observaciones;
  final String? controlSoplado;

  Produccion({
    this.id,
    required this.fechaProduccion,
    required this.numeroLote,
    required this.fechaVencimiento,
    required this.botellasEnvasadas,
    required this.botellasMalogradas,
    required this.tapasMalogradas,
    required this.etiquetasMalogradas,
    required this.totalBotellasBuenas,
    required this.totalPaquetes,
    this.empleado,
    this.observaciones,
    this.controlSoplado,
  });
}
