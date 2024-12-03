import 'package:flutter/material.dart';
import '../../../../models/data_model/inventario_model.dart';
import '../../../../models/data_model/producto_model.dart';

class InventoryPage extends StatelessWidget {
  final List<InventarioModel> inventory;
  final GlobalKey<FormState> formKey;
  final TextEditingController productNameController;
  final TextEditingController quantityController;
  final Function() onAddProduct;

  const InventoryPage({
    super.key,
    required this.inventory,
    required this.formKey,
    required this.productNameController,
    required this.quantityController,
    required this.onAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control de Existencias')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Control de Existencias',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: productNameController,
                      decoration: const InputDecoration(
                          labelText: 'Nombre del Producto'),
                      validator: (value) => value!.isEmpty
                          ? 'Por favor ingrese el nombre del producto'
                          : null,
                    ),
                    TextFormField(
                      controller: quantityController,
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty
                          ? 'Por favor ingrese la cantidad'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: onAddProduct,
                      child: const Text('Agregar / Actualizar Producto'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Producto')),
                    DataColumn(label: Text('Stock Actual')),
                    DataColumn(label: Text('Stock Mínimo')),
                    DataColumn(label: Text('Stock Máximo')),
                    DataColumn(label: Text('Nivel de Inventario')),
                  ],
                  rows: inventory
                      .map((item) => DataRow(cells: [
                            DataCell(Text(item.producto.toString())),
                            DataCell(Text(item.cantidadActual.toString())),
                            DataCell(Text(item.stockMinimo.toString())),
                            DataCell(Text(item.stockMaximo.toString())),
                            DataCell(LinearProgressIndicator(
                              value: item.cantidadActual / item.stockMaximo,
                              minHeight: 10,
                            )),
                          ]))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
