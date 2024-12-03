import '../../models/data_model/producto_model.dart';
import '../../repositories/data/producto/producto_repository.dart';

class GetProductos {
  final ProductoRepository repository;

  GetProductos(this.repository);

  Future<List<ProductoModel>> call() async {
    return await repository.getProductos();
  }
}

class GetProductoById {
  final ProductoRepository repository;

  GetProductoById(this.repository);

  Future<ProductoModel> call(int id) async {
    return await repository.getProductoById(id);
  }
}

class CreateProducto {
  final ProductoRepository repository;

  CreateProducto(this.repository);

  Future<void> call(ProductoModel producto) async {
    return await repository.createProducto(producto);
  }
}

class UpdateProducto {
  final ProductoRepository repository;

  UpdateProducto(this.repository);

  Future<void> call(int productoId, ProductoModel producto) async {
    return await repository.updateProducto(productoId, producto);
  }
}

class DeleteProducto {
  final ProductoRepository repository;

  DeleteProducto(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteProducto(id);
  }
}

class ProductoUseCase {
  final GetProductos getProductos;
  final GetProductoById getProductoById;
  final CreateProducto createProducto;
  final UpdateProducto updateProducto;
  final DeleteProducto deleteProducto;

  ProductoUseCase(ProductoRepository repository)
      : getProductos = GetProductos(repository),
        getProductoById = GetProductoById(repository),
        createProducto = CreateProducto(repository),
        updateProducto = UpdateProducto(repository),
        deleteProducto = DeleteProducto(repository);
}
