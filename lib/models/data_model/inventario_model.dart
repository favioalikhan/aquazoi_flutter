import 'package:intl/intl.dart';

import '../entity/inventario.dart';
import 'produccion_model.dart';
import 'producto_model.dart';

class InventarioModel extends Inventario {
  InventarioModel({
    super.id,
    required super.producto,
    required super.cantidadActual,
    required super.puntoReorden,
    required super.stockMinimo,
    required super.stockMaximo,
    required super.fechaVencimiento,
    super.controlProduccion,
    required super.fechaActualizacion,
  });

  // Convertir desde JSON a RolModel
  factory InventarioModel.fromJson(Map<String, dynamic> json) {
    return InventarioModel(
      id: json['id'],
      producto: json['producto'] != null
          ? ProductoModel.fromJson(json['producto'])
          : null,
      cantidadActual: json['cantidad_actual'],
      puntoReorden: json['punto_reorden'],
      stockMinimo: json['stock_minimo'],
      stockMaximo: json['stock_maximo'],
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
      'producto': producto?.id,
      'cantidad_actual': cantidadActual,
      'punto_reorden': puntoReorden,
      'stock_minimo': stockMinimo,
      'stock_maximo': stockMaximo,
      'fecha_vencimiento': dateFormat.format(fechaVencimiento),
      'controlproduccion': controlProduccion?.id,
      'fecha_actualizacion': dateFormat.format(fechaActualizacion),
    };
  }
}
