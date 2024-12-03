import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/data_model/producto_model.dart';
import '../../../usecases/producto/producto_usecase.dart';

// Eventos
abstract class ProductoEvent {}

class FetchProductosEvent extends ProductoEvent {}

class AddProductoEvent extends ProductoEvent {
  final ProductoModel producto;

  AddProductoEvent(this.producto);
}

class UpdateProductoEvent extends ProductoEvent {
  final ProductoModel producto;

  UpdateProductoEvent(this.producto);
}

class DeleteProductoEvent extends ProductoEvent {
  final int productoId;

  DeleteProductoEvent(this.productoId);
}

// Estados
abstract class ProductoState {}

class ProductoInitial extends ProductoState {}

class ProductoLoading extends ProductoState {}

class ProductosLoadedState extends ProductoState {
  final List<ProductoModel> productos;

  ProductosLoadedState(this.productos);
}

class ProductoOperationSuccess extends ProductoState {
  final ProductoModel producto;

  ProductoOperationSuccess(this.producto);
}

class ProductoDeletedSuccess extends ProductoState {
  final int productoId;

  ProductoDeletedSuccess(this.productoId);
}

class ProductoFailure extends ProductoState {
  final String error;

  ProductoFailure(this.error);
}

// Bloc
class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  final ProductoUseCase productoUseCase;

  ProductoBloc(this.productoUseCase) : super(ProductoInitial()) {
    // Obtener productos
    on<FetchProductosEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        final productos = await productoUseCase.getProductos();
        emit(ProductosLoadedState(productos));
      } catch (e) {
        emit(ProductoFailure(e.toString()));
      }
    });

    // Agregar producto
    on<AddProductoEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        await productoUseCase.createProducto(event.producto);
        emit(ProductoOperationSuccess(event.producto));
        add(FetchProductosEvent()); // Refrescar lista
      } catch (e) {
        emit(ProductoFailure(e.toString()));
      }
    });

    // Actualizar producto
    on<UpdateProductoEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        final productoId = event.producto.id;

        if (productoId == null) {
          throw Exception('El ID del producto no puede ser nulo');
        }

        await productoUseCase.updateProducto(productoId, event.producto);
        emit(ProductoOperationSuccess(event.producto));
        add(FetchProductosEvent()); // Refrescar lista
      } catch (e) {
        emit(ProductoFailure(e.toString()));
      }
    });

    // Eliminar producto
    on<DeleteProductoEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        await productoUseCase.deleteProducto(event.productoId);
        emit(ProductoDeletedSuccess(event.productoId));
        add(FetchProductosEvent()); // Refrescar lista
      } catch (e) {
        emit(ProductoFailure(e.toString()));
      }
    });
  }
}
