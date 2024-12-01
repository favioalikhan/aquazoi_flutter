import 'package:intl/intl.dart';

import '../entity/inventario.dart';
import 'produccion_model.dart';

class InventarioModel extends Inventario {
  InventarioModel({
    super.id,
    required super.producto,
    required super.numeroLote,
    required super.cantidadActual,
    super.puntoReorden,
    super.stockMinimo,
    required super.fechaVencimiento,
    super.controlProduccion,
    required super.fechaActualizacion,
  });

  // Convertir desde JSON a RolModel
  factory InventarioModel.fromJson(Map<String, dynamic> json) {
    return InventarioModel(
      id: json['id'],
      producto: json['producto'],
      numeroLote: json['numero_lote'],
      cantidadActual: json['cantidad_actual'],
      puntoReorden: json['punto_reorden'],
      stockMinimo: json['stock_minimo'],
      fechaVencimiento:
          DateFormat('yyyy-MM-dd').parseStrict(json['fecha_vencimiento']),
      controlProduccion: json['controlproduccion'] != null
          ? ProduccionModel.fromJson(json['controlproduccion'])
          : null,
      fechaActualizacion:
          DateFormat('yyyy-MM-dd').parseStrict(json['fecha_actualizacion']),
    );
  }

  // Convertir de RolModel a JSON
  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'producto': producto,
      'numero_lote': numeroLote,
      'cantidad_actual': cantidadActual,
      'punto_reorden': puntoReorden,
      'stock_minimo': stockMinimo,
      'fecha_vencimiento': dateFormat.format(fechaVencimiento),
      'controlproduccion': controlProduccion?.id,
      'fecha_actualizacion': dateFormat.format(fechaActualizacion),
    };
  }
}
