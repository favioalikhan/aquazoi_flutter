import '../entity/producto.dart';

class ProductoModel extends Producto {
  ProductoModel({
    super.id,
    required super.nombre,
    super.descripcion,
    required super.precioUnitario,
    required super.unidadMedida,
    super.estado,
  });

  // Convertir desde JSON a RolModel
  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precioUnitario: json['precio_unitario'],
      unidadMedida: json['unidad_medida'],
      estado: json['estado'],
    );
  }

  // Convertir de RolModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio_unitario': precioUnitario,
      'unidad_medida': unidadMedida,
      'estado': estado,
    };
  }
}
