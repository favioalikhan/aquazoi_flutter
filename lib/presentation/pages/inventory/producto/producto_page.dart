import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/data_model/producto_model.dart';
import '../../../bloc/producto/producto_bloc.dart';
import '../../../../repositories/data/producto/producto_repository_impl.dart';
import '../../../../services/api/api_client.dart';
import '../../../../usecases/producto/producto_usecase.dart';

class ProductoPage extends StatelessWidget {
  const ProductoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductoBloc(
        ProductoUseCase(ProductoRepositoryImpl(ApiClient())),
      )..add(FetchProductosEvent()),
      child: ProductoPageContent(),
    );
  }
}

class ProductoPageContent extends StatefulWidget {
  const ProductoPageContent({super.key});

  @override
  _ProductoPageContentState createState() => _ProductoPageContentState();
}

class _ProductoPageContentState extends State<ProductoPageContent> {
  final GlobalKey<FormState> _addFormKey = GlobalKey<FormState>();
  final TextEditingController _addNombreController = TextEditingController();
  final TextEditingController _addDescripcionController =
      TextEditingController();
  final TextEditingController _addPrecioController = TextEditingController();
  final TextEditingController _addUnidadMedidaController =
      TextEditingController();

  // Controladores para editar productos
  final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
  final TextEditingController _editNombreController = TextEditingController();
  final TextEditingController _editDescripcionController =
      TextEditingController();
  final TextEditingController _editPrecioController = TextEditingController();
  final TextEditingController _editUnidadMedidaController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductoBloc>().add(FetchProductosEvent());
  }

  void _addProducto() {
    if (_addFormKey.currentState!.validate()) {
      final producto = ProductoModel(
        nombre: _addNombreController.text,
        descripcion: _addDescripcionController.text.isNotEmpty
            ? _addDescripcionController.text
            : null,
        precioUnitario: double.tryParse(_addPrecioController.text) ?? 0.0,
        unidadMedida: _addUnidadMedidaController.text,
        estado: true,
      );
      context.read<ProductoBloc>().add(AddProductoEvent(producto));
      _clearAddForm();
    }
  }

  void _clearAddForm() {
    _addNombreController.clear();
    _addDescripcionController.clear();
    _addPrecioController.clear();
    _addUnidadMedidaController.clear();
  }

  void _deleteProducto(int? productoId) {
    if (productoId != null) {
      context.read<ProductoBloc>().add(DeleteProductoEvent(productoId));
    } else {
      // Muestra un mensaje de error si el id es nulo
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Producto no tiene ID')),
      );
    }
  }

  void _updateProducto(int productoId) {
    final productoActualizado = ProductoModel(
      id: productoId,
      nombre: _editNombreController.text,
      descripcion: _editDescripcionController.text.isNotEmpty
          ? _editDescripcionController.text
          : null,
      precioUnitario: double.tryParse(_editPrecioController.text) ?? 0.0,
      unidadMedida: _editUnidadMedidaController.text,
      estado: true,
    );
    context.read<ProductoBloc>().add(UpdateProductoEvent(productoActualizado));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Productos')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gestión de Productos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Form(
                key: _addFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _addNombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addDescripcionController,
                      decoration:
                          const InputDecoration(labelText: 'Descripción'),
                    ),
                    TextFormField(
                      controller: _addPrecioController,
                      decoration:
                          const InputDecoration(labelText: 'Precio Unitario'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese un precio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _addUnidadMedidaController,
                      decoration:
                          const InputDecoration(labelText: 'Unidad de Medida'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese una unidad de medida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addProducto,
                      child: const Text('Agregar Producto'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocBuilder<ProductoBloc, ProductoState>(
                  builder: (context, state) {
                    if (state is ProductoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductosLoadedState) {
                      final productos = state.productos;
                      return DataTable(
                        columns: const [
                          DataColumn(label: Text('Nombre')),
                          DataColumn(label: Text('Descripción')),
                          DataColumn(label: Text('Precio Unitario')),
                          DataColumn(label: Text('Unidad Medida')),
                          DataColumn(label: Text('Acciones')),
                        ],
                        rows: productos
                            .map(
                              (producto) => DataRow(cells: [
                                DataCell(Text(producto.nombre.toString())),
                                DataCell(Text(producto.descripcion ?? '-----')),
                                DataCell(
                                    Text(producto.precioUnitario.toString())),
                                DataCell(
                                    Text(producto.unidadMedida.toString())),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          _showEditDialog(producto);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            _deleteProducto(producto.id!),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            )
                            .toList(),
                      );
                    } else if (state is ProductoFailure) {
                      // En lugar de solo mostrar el error, refrescar la tabla
                      // Puedes intentar refrescar la lista de productos tras un error.
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.read<ProductoBloc>().add(FetchProductosEvent());
                      });

                      // Aquí se muestra el error como un widget de información adicional.
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('', style: TextStyle(color: Colors.red)),
                            const SizedBox(height: 16),
                            const CircularProgressIndicator(), // Mientras se recarga
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                          child: Text('No hay productos disponibles.'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(ProductoModel producto) {
    // Inicializar los controladores de edición con los valores del producto
    _editNombreController.text = producto.nombre;
    _editDescripcionController.text = producto.descripcion ?? '';
    _editPrecioController.text = producto.precioUnitario.toString();
    _editUnidadMedidaController.text = producto.unidadMedida;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Producto'),
          content: Form(
            key: _editFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _editNombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _editDescripcionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                ),
                TextFormField(
                  controller: _editPrecioController,
                  decoration:
                      const InputDecoration(labelText: 'Precio Unitario'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un precio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _editUnidadMedidaController,
                  decoration:
                      const InputDecoration(labelText: 'Unidad de Medida'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese una unidad de medida';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_editFormKey.currentState!.validate()) {
                  _updateProducto(producto.id!);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
