import 'package:intl/intl.dart';

import '../entity/soplado.dart';
import 'empleado_model.dart';

class SopladoModel extends Soplado {
  SopladoModel({
    super.id,
    required super.fecha,
    required super.proveedorPreforma,
    required super.pesoGramos,
    required super.volumenBotellaMl,
    required super.produccionBuena,
    required super.produccionDanada,
    required super.produccionTotal,
    super.empleado,
    super.observaciones,
  });
  // Convertir desde JSON a RolModel
  factory SopladoModel.fromJson(Map<String, dynamic> json) {
    return SopladoModel(
      id: json['id'],
      fecha: DateFormat('yyyy-MM-dd').parseStrict(json['fecha']),
      proveedorPreforma: json['proveedorPreforma'],
      pesoGramos: json['pesoGramos'],
      volumenBotellaMl: json['volumenBotellaMl'],
      produccionBuena: json['produccionBuena'],
      produccionDanada: json['produccionDanada'],
      produccionTotal: json['produccionTotal'],
      empleado: json['empleado'] != null
          ? EmpleadoModel.fromJson(json['empleado'])
          : null,
      observaciones: json['observaciones'],
    );
  }

  // Convertir de RolModel a JSON
  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'fecha': dateFormat.format(fecha),
      'proveedorPreforma': proveedorPreforma,
      'pesoGramos': pesoGramos,
      'volumenBotellaMl': volumenBotellaMl,
      'produccionBuena': produccionBuena,
      'produccionDanada': produccionDanada,
      'produccionTotal': produccionTotal,
      'empleado': empleado?.id,
      'observaciones': observaciones,
    };
  }
}
