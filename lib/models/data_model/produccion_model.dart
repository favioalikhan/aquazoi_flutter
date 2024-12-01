import 'package:intl/intl.dart';

import '../entity/produccion.dart';
import 'empleado_model.dart';

class ProduccionModel extends Produccion {
  ProduccionModel({
    super.id,
    required super.fechaProduccion,
    required super.numeroLote,
    required super.fechaVencimiento,
    required super.botellasEnvasadas,
    required super.botellasMalogradas,
    required super.tapasMalogradas,
    required super.etiquetasMalogradas,
    required super.totalBotellasBuenas,
    required super.totalPaquetes,
    super.empleado,
    super.observaciones,
    super.controlSoplado,
  });

  // Convertir desde JSON a RolModel
  factory ProduccionModel.fromJson(Map<String, dynamic> json) {
    return ProduccionModel(
      id: json['id'],
      fechaProduccion:
          DateFormat('yyyy-MM-dd').parseStrict(json['fecha_Produccion']),
      numeroLote: json['numero_Lote'],
      fechaVencimiento:
          DateFormat('yyyy-MM-dd').parseStrict(json['fecha_Vencimiento']),
      botellasEnvasadas: json['botellas_Envasadas'],
      botellasMalogradas: json['botellas_Malogradas'],
      tapasMalogradas: json['tapas_Malogradas'],
      etiquetasMalogradas: json['etiquetas_Malogradas'],
      totalBotellasBuenas: json['total_Botellas_Buenas'],
      totalPaquetes: json['total_Paquetes'],
      empleado: json['empleado'] != null
          ? EmpleadoModel.fromJson(json['empleado'])
          : null,
      observaciones: json['observaciones'],
      controlSoplado: json['control_Soplado'],
    );
  }

  // Convertir de RolModel a JSON
  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'fecha_Produccion': dateFormat.format(fechaProduccion),
      'numero_Lote': numeroLote,
      'fecha_Vencimiento': dateFormat.format(fechaVencimiento),
      'botellas_Envasadas': botellasEnvasadas,
      'botellas_Malogradas': botellasMalogradas,
      'tapas_Malogradas': tapasMalogradas,
      'etiquetas_Malogradas': etiquetasMalogradas,
      'total_Botellas_Buenas': totalBotellasBuenas,
      'total_Paquetes': totalPaquetes,
      'empleado': empleado?.id,
      'observaciones': observaciones,
      'control_Soplado': controlSoplado,
    };
  }
}
