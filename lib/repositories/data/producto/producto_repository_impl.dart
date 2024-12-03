import '../../../services/api/api_client.dart';
import '../../../services/api/endpoints.dart';
import '../../../models/data_model/producto_model.dart';
import '../../../repositories/data/producto/producto_repository.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final ApiClient apiClient;

  ProductoRepositoryImpl(this.apiClient);

  @override
  Future<List<ProductoModel>> getProductos() async {
    final response = await apiClient.get(ApiEndpoints.producto);

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => ProductoModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener productos');
    }
  }

  @override
  Future<ProductoModel> getProductoById(int id) async {
    final response = await apiClient.get('${ApiEndpoints.producto}/$id');

    if (response.statusCode == 200) {
      return ProductoModel.fromJson(response.data);
    } else {
      throw Exception('Error al obtener el producto');
    }
  }

  @override
  Future<void> createProducto(ProductoModel producto) async {
    final response = await apiClient.post(
      ApiEndpoints.producto,
      producto.toJson(),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al agregar producto');
    }
  }

  @override
  Future<ProductoModel> updateProducto(
      int productoId, ProductoModel producto) async {
    final productoJson = producto.toJson();
    final response = await apiClient.put(
      ApiEndpoints.updateProducto(productoId),
      productoJson,
    );

    if (response.statusCode == 200) {
      return ProductoModel.fromJson(response.data);
    } else {
      throw Exception('Error al actualizar empleado: ${response.statusCode}');
    }
  }

  @override
  Future<ProductoModel> deleteProducto(int productoId) async {
    final response = await apiClient.delete(
      ApiEndpoints.deleteProducto(productoId), // Usando el endpoint correcto
    );

    if (response.statusCode == 200) {
      return ProductoModel.fromJson(response.data);
    } else {
      throw Exception('Error al eliminar producto: ${response.data['detail']}');
    }
  }
}
