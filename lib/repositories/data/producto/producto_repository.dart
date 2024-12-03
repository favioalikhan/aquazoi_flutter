import '../../../models/data_model/producto_model.dart';

abstract class ProductoRepository {
  Future<List<ProductoModel>> getProductos();
  Future<ProductoModel> getProductoById(int id);
  Future<void> createProducto(ProductoModel producto);
  Future<void> updateProducto(int id, ProductoModel producto);
  Future<void> deleteProducto(int id);
}
